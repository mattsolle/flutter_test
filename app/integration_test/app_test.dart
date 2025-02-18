import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/home.dart';
import 'package:i18n/i18n.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_tour/main.dart';
import 'package:restaurant_tour/src/router/app_router.dart';
import 'package:restaurant_tour/src/splash/widgets/splash_screen.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockRestaurantsRepository extends Mock
    implements RestaurantsRepositoryImpl {}

// ignore: lines_longer_than_80_chars
class MockLocalBookmarkRepository extends Mock
    implements LocalRepository<Bookmarks> {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockRestaurantsRepository mockRepository;
  late List<Restaurant> restaurants;

  List<Restaurant> generateRestaurants(int length) {
    final restaurants = <Restaurant>[];
    for (var i = 1; i <= length; i++) {
      restaurants.add(
        Restaurant(
          id: '$i',
          name: 'Mock Restaurant $i',
          price: '\$\$\$',
          rating: 5,
          photos: [
            'https://s3-media2.fl.yelpcdn.com/bphoto/tCtf8fuCixmEXQ93uizejw/o.jpg',
          ],
          reviews: [],
          categories: [
            Category(alias: '_alias', title: '_category'),
          ],
          hours: [
            Hours(isOpenNow: i.isOdd),
          ],
          location: Location(formattedAddress: '_formattedAddress'),
        ),
      );
    }
    return restaurants;
  }

  Future<void> initDependencies() async {
    // Create mock repository
    mockRepository = MockRestaurantsRepository();

    // Register dependencies
    di.registerFactory<HttpClient>(MockHttpClient.new);
    di.registerFactory<RestaurantsRepository>(() => mockRepository);
    di.registerSingleton<FlutterSecureStorage>(MockFlutterSecureStorage());
    di.registerFactory<LocalRepository<Bookmarks>>(
      MockLocalBookmarkRepository.new,
    );

    // Simulate API returning mock data
    restaurants = generateRestaurants(10);
    when(mockRepository.fetchRestaurants).thenAnswer(
      (_) async {
        return (restaurants, restaurants.length);
      },
    );
    when(() => mockRepository.getRestaurantById('1')).thenAnswer(
      (_) async => const Restaurant(id: '1', name: 'Mock Restaurant 1'),
    );
  }

  testWidgets(
    'Example flow: open app, click on the first and second restaurants,'
    'favorite them, navigate to the favorites tab, and verify they are listed.',
    (tester) async {
      // Start dependency injection
      await initDependencies();

      // Start App
      await tester.pumpWidget(const RestaurantTourApp());
      await tester.pump();

      final context = tester.element(find.byType(AppRouter));

      // Ensure the SplashScreen is visible before it navigates to the home
      expect(find.byType(SplashScreen), findsOneWidget);
      await tester.pumpAndSettle();

      // Ensure the HomeScreen is visible
      final l10n = I18NextL10n(context, namespace: 'home');
      expect(find.text(l10n.localize('title')), findsOneWidget);

      // Taps the first restaurant
      final firstRestaurant = restaurants.first;

      await tester.tap(find.text(firstRestaurant.name!));
      await tester.pumpAndSettle();

      expect(find.text(firstRestaurant.name!), findsOneWidget);
      expect(
        find.text(firstRestaurant.categories!.first.title!),
        findsOneWidget,
      );
      expect(
        find.text(firstRestaurant.location!.formattedAddress!),
        findsOneWidget,
      );

      // Taps the back button.
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Taps the seconde restaurant
      final secondRestaurant = restaurants[1];

      await tester.tap(find.text(secondRestaurant.name!));
      await tester.pumpAndSettle();

      expect(find.text(secondRestaurant.name!), findsOneWidget);
      expect(
        find.text(secondRestaurant.categories!.first.title!),
        findsOneWidget,
      );
      expect(
        find.text(secondRestaurant.location!.formattedAddress!),
        findsOneWidget,
      );

      // Taps the back button.
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
    },
  );
}
