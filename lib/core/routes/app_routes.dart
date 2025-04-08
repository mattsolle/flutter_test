enum AppRoutes {
  restaurants,
  restaurantDetails,
  favoriteRestaurants,
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.restaurants:
        return '/';
      case AppRoutes.restaurantDetails:
        return '/restaurant-details';
      case AppRoutes.favoriteRestaurants:
        return '/favorite-restaurants';
    }
  }

  String get name {
    switch (this) {
      case AppRoutes.restaurants:
        return 'restaurants';
      case AppRoutes.restaurantDetails:
        return 'restaurantDetails';
      case AppRoutes.favoriteRestaurants:
        return 'favoriteRestaurants';
    }
  }
}
