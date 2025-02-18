import 'package:core/core.dart';
import 'package:core/get_it.dart';
import 'package:core/test_utils.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/l10n/home_l10n.dart';
import 'package:home/src/bookmarks/data/models/bookmarks.dart';
import 'package:home/src/restaurants/blocs/restaurants_cubit.dart';
import 'package:home/src/restaurants/data/repositories/restaurants_repository.dart';
import 'package:home/src/restaurants/widgets/bookmarked_restaurants_container.dart';
import 'package:home/src/restaurants/widgets/restaurants_container.dart';
import 'package:home/src/widgets/home_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockRestaurantsCubit extends Mock implements RestaurantsCubit {}

class MockRestaurantsRepository extends Mock implements RestaurantsRepository {}

class MockLocalRepository extends Mock implements LocalRepository<Bookmarks> {}

void main() {
  late GetIt getIt;
  late MockRestaurantsCubit mockRestaurantsCubit;
  late MockRestaurantsRepository mockRestaurantsRepository;

  setUp(() {
    getIt = GetIt.instance;

    // Reset GetIt to avoid conflicts
    getIt.reset();

    // Mock Dependencies
    mockRestaurantsCubit = MockRestaurantsCubit();
    mockRestaurantsRepository = MockRestaurantsRepository();

    // Register mocks
    getIt.registerSingleton<RestaurantsRepository>(mockRestaurantsRepository);
    getIt.registerSingleton<RestaurantsCubit>(mockRestaurantsCubit);
    getIt.registerSingleton<LocalRepository<Bookmarks>>(MockLocalRepository());
  });

  testWidgets(
    'renders HomeScreen with correct AppBar title',
    (tester) async {
      late HomeL10n l10n;

      await tester.pumpWidget(
        SetupAppTester(
          child: Builder(
            builder: (context) {
              l10n = HomeL10n.of(context);
              return const HomeScreen();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(l10n.title), findsOneWidget);
    },
  );

  testWidgets(
    'renders tabs with correct labels',
    (tester) async {
      late HomeL10n l10n;

      await tester.pumpWidget(
        SetupAppTester(
          child: Builder(
            builder: (context) {
              l10n = HomeL10n.of(context);
              return const HomeScreen();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(l10n.restaurantsTab), findsOneWidget);
      expect(find.text(l10n.bookmarksTab), findsOneWidget);
    },
  );

  testWidgets(
    'switches to Bookmarks tab when tapped',
    (tester) async {
      late HomeL10n l10n;

      await tester.pumpWidget(
        SetupAppTester(
          child: Builder(
            builder: (context) {
              l10n = HomeL10n.of(context);
              return const HomeScreen();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RestaurantsContainer), findsOneWidget);
      expect(find.byType(BookmarkedRestaurantsContainer), findsNothing);

      await tester.tap(find.text(l10n.bookmarksTab));
      await tester.pumpAndSettle();

      expect(find.byType(RestaurantsContainer), findsNothing);
      expect(find.byType(BookmarkedRestaurantsContainer), findsOneWidget);
    },
  );

  testWidgets(
    'maintains state when switching tabs',
    (tester) async {
      late HomeL10n l10n;

      await tester.pumpWidget(
        SetupAppTester(
          child: Builder(
            builder: (context) {
              l10n = HomeL10n.of(context);
              return const HomeScreen();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(l10n.bookmarksTab));
      await tester.pumpAndSettle();
      expect(find.byType(BookmarkedRestaurantsContainer), findsOneWidget);

      await tester.tap(find.text(l10n.restaurantsTab));
      await tester.pumpAndSettle();
      expect(find.byType(RestaurantsContainer), findsOneWidget);
    },
  );
}
