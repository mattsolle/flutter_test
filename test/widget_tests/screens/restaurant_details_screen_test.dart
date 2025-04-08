import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/favourite_restaurants/favourite_restaurants_cubit.dart';
import 'package:restaurant_tour/features/restaurant/presentation/screens/restaurant_details_screen.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/favourite_button_widget.dart';
import '../../mocks.dart';

void main() {
  late Restaurant mockRestaurant;
  late MockFavoriteRestaurantsCubit mockFavoriteRestaurantsCubit;

  setUp(() {
    mockRestaurant = createMockRestaurants(1).first;
    mockFavoriteRestaurantsCubit = MockFavoriteRestaurantsCubit();
    when(() => mockFavoriteRestaurantsCubit.state)
        .thenReturn(FavoriteRestaurantsInitial());
    when(() => mockFavoriteRestaurantsCubit.stream)
        .thenAnswer((_) => const Stream.empty());
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<FavoriteRestaurantsCubit>.value(
        value: mockFavoriteRestaurantsCubit,
        child: RestaurantDetailsScreen(restaurant: mockRestaurant),
      ),
    );
  }

  group('RestaurantDetailsScreen Widget Tests', () {
    testWidgets('Display restaurant name in AppBar',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text(mockRestaurant.name ?? ''), findsOneWidget);
    });

    testWidgets('Display restaurant hero image', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Hero), findsOneWidget);
    });

    testWidgets('Show restaurant price and category',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(
        find.text(
          "${mockRestaurant.price ?? ''} ${mockRestaurant.displayCategory}",
        ),
        findsOneWidget,
      );
    });

    testWidgets('Display restaurant status (open or closed)',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(
        find.byType(Icon),
        findsWidgets,
      );
    });

    testWidgets('Display restaurant rating', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(
        find.text(mockRestaurant.rating?.toString() ?? 'N/A'),
        findsOneWidget,
      );

      expect(find.byIcon(Icons.star), findsAtLeast(1));
    });

    testWidgets('Display restaurant address', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(
        find.text(mockRestaurant.location?.formattedAddress ?? ''),
        findsOneWidget,
      );
    });

    testWidgets('Display reviews if available', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(
        find.text(mockRestaurant.reviews?.first.text ?? ''),
        findsOneWidget,
      );
    });

    testWidgets('Show favorite button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(FavoriteButtonWidget), findsOneWidget);
    });
  });
}
