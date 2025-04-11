import '../architecture/result.dart';
import '../entities/restaurant_entity.dart';
import '../query_entity/get_restaurant_details_query_entity.dart';

abstract interface class GetRestaurantDetailsUseCase {
  const GetRestaurantDetailsUseCase();

  Future<Result<RestaurantEntity>> call(
    GetRestaurantDetailsQueryEntity query,
  );
}
