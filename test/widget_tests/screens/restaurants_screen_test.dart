import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/core/constants/app_tabs.dart';
import 'package:restaurant_tour/core/di/service_locator.dart';
import 'package:restaurant_tour/core/routes/app_routes.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/favourite_restaurants/favourite_restaurants_cubit.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/tab_navigation/tab_navigation_cubit.dart';
import 'package:restaurant_tour/features/restaurant/presentation/blocs/restaurant/restaurant_bloc.dart';
import 'package:restaurant_tour/features/restaurant/presentation/screens/restaurants_screen.dart';

import '../../mocks.dart';

void main() {
  late MockTabNavigationCubit mockTabNavigationCubit;
  late MockRestaurantBloc mockRestaurantBloc;
  late MockFavoriteRestaurantsCubit mockFavoriteRestaurantsCubit;
  late GoRouter router;

  setUp(() {
    getIt.reset();
    setupLocator();

    router = getIt<GoRouter>();

    mockTabNavigationCubit = MockTabNavigationCubit();
    mockFavoriteRestaurantsCubit = MockFavoriteRestaurantsCubit();
    mockRestaurantBloc = MockRestaurantBloc();

    when(() => mockTabNavigationCubit.state)
        .thenReturn(const TabNavigationTabChanged(0));
    when(() => mockTabNavigationCubit.stream)
        .thenAnswer((_) => Stream.value(const TabNavigationTabChanged(0)));
    when(() => mockTabNavigationCubit.getRoute(any())).thenAnswer((invocation) {
      final int index = invocation.positionalArguments.first;
      return AppTabs.items[index].routeName;
    });
    when(() => mockTabNavigationCubit.navigateToTab(any())).thenReturn(null);

    when(() => mockFavoriteRestaurantsCubit.state)
        .thenReturn(FavoriteRestaurantsInitial());
    when(() => mockFavoriteRestaurantsCubit.stream)
        .thenAnswer((_) => Stream.value(FavoriteRestaurantsInitial()));

    when(() => mockRestaurantBloc.state).thenReturn(RestaurantInitial());
    when(() => mockRestaurantBloc.stream)
        .thenAnswer((_) => Stream.value(RestaurantInitial()));
  });

  Widget buildTestableWidget(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabNavigationCubit>.value(value: mockTabNavigationCubit),
        BlocProvider<RestaurantBloc>.value(value: mockRestaurantBloc),
        BlocProvider<FavoriteRestaurantsCubit>.value(
          value: mockFavoriteRestaurantsCubit,
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }

  void verifyNavigationTo(String expectedPath) {
    expect(router.routeInformationProvider.value.uri.toString(), expectedPath);
  }

  group('RestaurantsScreen Widget Tests', () {
    testWidgets('Render RestaurantsScreen with correct tabs', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const RestaurantsScreen(child: SizedBox.shrink())),
      );

      expect(find.byType(TabBar), findsOneWidget);
      expect(find.text(AppStrings.allRestaurants), findsOneWidget);
      expect(find.text(AppStrings.myFavorites), findsOneWidget);
    });

    testWidgets('Display correct tab based on cubit state', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const RestaurantsScreen(child: SizedBox.shrink())),
      );

      expect(find.byType(DefaultTabController), findsOneWidget);
      expect(find.text(AppTabs.items[0].title), findsOneWidget);
    });

    testWidgets(
        'Switch to FavoriteRestaurantsScreen when My Favorites tab is tapped',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const RestaurantsScreen(child: SizedBox.shrink())),
      );

      await tester.tap(find.text(AppTabs.items[1].title));
      await tester.pump();

      verify(() => mockTabNavigationCubit.navigateToTab(1)).called(1);
      verifyNavigationTo(AppRoutes.favoriteRestaurants.path); // ✅ Optimized
    });

    testWidgets('Maintain state when switching between tabs', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const RestaurantsScreen(child: SizedBox.shrink())),
      );

      await tester.tap(find.text(AppTabs.items[1].title));
      await tester.pump();

      verify(() => mockTabNavigationCubit.navigateToTab(1)).called(1);
      verifyNavigationTo(AppRoutes.favoriteRestaurants.path);

      await tester.tap(find.text(AppTabs.items[0].title));
      await tester.pump();

      verify(() => mockTabNavigationCubit.navigateToTab(0)).called(1);
      verifyNavigationTo(AppRoutes.restaurants.path);
    });

    testWidgets('Should have AppBar with correct title', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const RestaurantsScreen(child: SizedBox.shrink())),
      );

      expect(find.text(AppStrings.appTitle), findsOneWidget);
    });

    testWidgets('Verify navigation triggers when clicking My Favorites tab',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const RestaurantsScreen(child: SizedBox.shrink())),
      );

      await tester.tap(find.text(AppStrings.myFavorites));
      await tester.pump();

      verifyNavigationTo(AppRoutes.favoriteRestaurants.path);
    });
  });
}
