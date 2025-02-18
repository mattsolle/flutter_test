import 'package:core/test_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/src/restaurants/data/models/restaurant.dart';
import 'package:home/src/restaurants/widgets/restaurants_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

void main() {
  const testRestaurant = Restaurant(id: '1', name: 'Test Restaurant');
  final mockRestaurants = <Restaurant>[testRestaurant];

  testWidgets('renders successfully with controller', (tester) async {
    final pagingController = PagingController<int, Restaurant>(firstPageKey: 0);

    await tester.pumpWidget(
      SetupAppTester(
        child: RestaurantsScreen(
          controller: pagingController,
          onRestaurantPressed: (_) => expectAsync0(() {}),
        ),
      ),
    );

    pagingController.appendLastPage(mockRestaurants);
    await tester.pumpAndSettle();

    expect(find.byType(RestaurantsScreen), findsOneWidget);
    await tester.pump();

    addTearDown(pagingController.dispose);
  });

  testWidgets('renders successfully with restaurants list', (tester) async {
    await tester.pumpWidget(
      SetupAppTester(
        child: RestaurantsScreen(
          restaurants: mockRestaurants,
          onRestaurantPressed: (_) => expectAsync0(() {}),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(RestaurantsScreen), findsOneWidget);
    expect(find.text('Test Restaurant'), findsOneWidget);
  });

  testWidgets(
      'throws assertion error when both'
      'controller and restaurants are provided', (tester) async {
    final pagingController = PagingController<int, Restaurant>(firstPageKey: 0);
    expect(
      () => RestaurantsScreen(
        controller: pagingController,
        restaurants: mockRestaurants,
        onRestaurantPressed: (_) => expectAsync0(() {}),
      ),
      throwsAssertionError,
    );

    addTearDown(pagingController.dispose);
  });

  testWidgets('calls onRestaurantPressed when a restaurant is tapped',
      (tester) async {
    await tester.pumpWidget(
      SetupAppTester(
        child: RestaurantsScreen(
          restaurants: mockRestaurants,
          onRestaurantPressed: expectAsync1((restaurant) {
            expect(restaurant.name, 'Test Restaurant');
          }),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(RestaurantsScreen), findsOneWidget);
    await tester.tap(find.text('Test Restaurant'));
    await tester.pump();
  });
}
