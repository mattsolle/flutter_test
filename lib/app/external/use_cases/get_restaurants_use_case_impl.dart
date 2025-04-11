import '../../domain/architecture/result.dart';
import '../../domain/entities/restaurant_query_result_entity.dart';
import '../../domain/query_entity/get_restaurants_query_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../../domain/use_cases/get_restaurants_use_case.dart';

class GetRestaurantsUseCaseImpl implements GetRestaurantsUseCase {
  const GetRestaurantsUseCaseImpl(this.repository);

  final RestaurantRepository repository;

  @override
  Future<Result<RestaurantQueryResultEntity>> call(
    GetRestaurantsQueryEntity query,
  ) {
    return repository.getRestaurants(query);
  }
}
