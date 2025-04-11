import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_tour/app/domain/architecture/result.dart';
import 'package:restaurant_tour/app/domain/entities/restaurant_query_result_entity.dart';
import 'package:restaurant_tour/app/domain/query_entity/get_restaurants_query_entity.dart';
import 'package:restaurant_tour/app/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_tour/app/external/use_cases/get_restaurants_use_case_impl.dart';

import 'get_restaurants_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RestaurantRepository>(),
  MockSpec<GetRestaurantsQueryEntity>(),
])
void main() {
  group('Unit Test - GetRestaurantsUseCaseImpl', () {
    late GetRestaurantsUseCaseImpl useCase;
    late MockRestaurantRepository repository;
    late MockGetRestaurantsQueryEntity query;

    setUp(() {
      repository = MockRestaurantRepository();
      query = MockGetRestaurantsQueryEntity();
      useCase = GetRestaurantsUseCaseImpl(repository);
    });

    test(
      'Given the GetRestaurantsUseCaseImpl, \n'
      'When called with a valid query, \n'
      'Then it should return the result from the repository',
      () async {
        const expectedResult = Result.success(RestaurantQueryResultEntity());

        when(repository.getRestaurants(query))
            .thenAnswer((_) async => expectedResult);

        final result = await useCase(query);

        expect(result, expectedResult);
        verify(repository.getRestaurants(query)).called(1);
      },
    );
  });
}
