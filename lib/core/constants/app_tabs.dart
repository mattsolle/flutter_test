import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/core/routes/app_routes.dart';
import 'package:restaurant_tour/features/restaurant/presentation/models/tab_items.dart';

class AppTabs {
  static final List<TabItem> items = [
    TabItem(
      title: AppStrings.allRestaurants,
      routeName: AppRoutes.restaurants.name,
    ),
    TabItem(
      title: AppStrings.myFavorites,
      routeName: AppRoutes.favoriteRestaurants.name,
    ),
  ];
}
