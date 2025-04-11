import 'restaurant_entity.dart';

class RestaurantQueryResultEntity {
  const RestaurantQueryResultEntity({
    this.total,
    this.restaurants,
  });

  final int? total;
  final List<RestaurantEntity>? restaurants;
}
