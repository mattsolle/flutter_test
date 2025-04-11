import '../../domain/architecture/result.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/query_entity/get_restaurant_details_query_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../../domain/use_cases/get_restaurant_details_use_case.dart';

class GetRestaurantDetailsUseCaseImpl implements GetRestaurantDetailsUseCase {
  const GetRestaurantDetailsUseCaseImpl(this.repository);

  final RestaurantRepository repository;

  @override
  Future<Result<RestaurantEntity>> call(
    GetRestaurantDetailsQueryEntity query,
  ) {
    return repository.getRestaurantDetails(query);
  }
}
