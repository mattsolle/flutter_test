import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_tour/core/routes/app_routes.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/tab_navigation/tab_navigation_cubit.dart';

void main() {
  late TabNavigationCubit tabNavigationCubit;

  setUp(() {
    tabNavigationCubit = TabNavigationCubit();
  });

  tearDown(() {
    tabNavigationCubit.close();
  });

  group('TabNavigationCubit', () {
    test('initial state should be TabNavigationInitial with index 0', () {
      expect(tabNavigationCubit.state, equals(const TabNavigationInitial()));
    });

    test('navigateToTab should emit TabNavigationTabChanged with correct index',
        () {
      const int newIndex = 1;

      expectLater(
        tabNavigationCubit.stream,
        emits(const TabNavigationTabChanged(newIndex)),
      );

      tabNavigationCubit.navigateToTab(newIndex);
    });

    test('getRoute should return correct route name based on index', () {
      expect(
        tabNavigationCubit.getRoute(0),
        equals(AppRoutes.restaurants.name),
      );
      expect(
        tabNavigationCubit.getRoute(1),
        equals(AppRoutes.favoriteRestaurants.name),
      );
    });

    test('should not emit duplicate states if navigating to the same tab', () {
      tabNavigationCubit.navigateToTab(1);

      expectLater(
        tabNavigationCubit.stream,
        emitsInOrder([]),
      );

      tabNavigationCubit.navigateToTab(1);
    });
  });
}
