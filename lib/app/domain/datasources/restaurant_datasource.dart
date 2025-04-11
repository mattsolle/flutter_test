import '../entities/restaurant_entity.dart';
import '../entities/restaurant_query_result_entity.dart';
import '../query_entity/get_restaurant_details_query_entity.dart';
import '../query_entity/get_restaurants_query_entity.dart';

abstract interface class RestaurantDatasource {
  Future<RestaurantQueryResultEntity> getRestaurants(
    GetRestaurantsQueryEntity query,
  );

  Future<RestaurantEntity> getRestaurantDetails(
    GetRestaurantDetailsQueryEntity query,
  );
}
