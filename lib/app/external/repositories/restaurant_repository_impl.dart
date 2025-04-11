import '../../domain/architecture/result.dart';
import '../../domain/datasources/restaurant_datasource.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/entities/restaurant_query_result_entity.dart';
import '../../domain/query_entity/get_restaurant_details_query_entity.dart';
import '../../domain/query_entity/get_restaurants_query_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  const RestaurantRepositoryImpl(this.datasource);

  final RestaurantDatasource datasource;

  @override
  Future<Result<RestaurantQueryResultEntity>> getRestaurants(
    GetRestaurantsQueryEntity query,
  ) async {
    try {
      final result = await datasource.getRestaurants(query);
      return Result.success(result);
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }

  @override
  Future<Result<RestaurantEntity>> getRestaurantDetails(
    GetRestaurantDetailsQueryEntity query,
  ) async {
    try {
      final result = await datasource.getRestaurantDetails(query);
      return Result.success(result);
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }
}
