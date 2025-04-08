import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/features/restaurant/presentation/screens/favourite_restaurants_screen.dart';
import 'package:restaurant_tour/features/restaurant/presentation/screens/restaurants_list_screen.dart';
import 'package:restaurant_tour/features/restaurant/presentation/screens/restaurant_details_screen.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import 'package:restaurant_tour/core/routes/app_routes.dart';
import 'package:restaurant_tour/features/restaurant/presentation/screens/restaurants_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();
  GoRouter get router => GoRouter(
        initialLocation: AppRoutes.restaurants.path,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return RestaurantsScreen(child: child);
            },
            routes: [
              GoRoute(
                path: AppRoutes.restaurants.path,
                name: AppRoutes.restaurants.name,
                builder: (context, state) => const RestaurantsListScreen(),
              ),
              GoRoute(
                path: AppRoutes.favoriteRestaurants.path,
                name: AppRoutes.favoriteRestaurants.name,
                builder: (context, state) => const FavoriteRestaurantsScreen(),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.restaurantDetails.path,
            name: AppRoutes.restaurantDetails.name,
            builder: (context, state) {
              final restaurant = state.extra as Restaurant?;
              if (restaurant == null) {
                throw Exception(AppStrings.restaurantDetailsRequired);
              }
              return RestaurantDetailsScreen(restaurant: restaurant);
            },
          ),
        ],
      );
}
