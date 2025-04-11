import '../architecture/result.dart';
import '../entities/restaurant_query_result_entity.dart';
import '../query_entity/get_restaurants_query_entity.dart';

abstract interface class GetRestaurantsUseCase {
  const GetRestaurantsUseCase();

  Future<Result<RestaurantQueryResultEntity>> call(
    GetRestaurantsQueryEntity query,
  );
}
