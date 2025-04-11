import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_tour/app/domain/architecture/result.dart';
import 'package:restaurant_tour/app/domain/entities/restaurant_entity.dart';
import 'package:restaurant_tour/app/domain/query_entity/get_restaurant_details_query_entity.dart';
import 'package:restaurant_tour/app/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_tour/app/external/use_cases/get_restaurant_use_case_impl.dart';

import 'get_restaurant_details_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RestaurantRepository>(),
  MockSpec<GetRestaurantDetailsQueryEntity>(),
])
void main() {
  group('Unit Test - GetRestaurantDetailsUseCaseImpl', () {
    late GetRestaurantDetailsUseCaseImpl useCase;
    late MockRestaurantRepository repository;
    late MockGetRestaurantDetailsQueryEntity query;

    setUp(() {
      repository = MockRestaurantRepository();
      query = MockGetRestaurantDetailsQueryEntity();
      useCase = GetRestaurantDetailsUseCaseImpl(repository);
    });

    test(
      'Given the GetRestaurantDetailsUseCaseImpl, \n'
      'When called with a valid query, \n'
      'Then it should return the result from the repository',
      () async {
        const expectedResult = Result.success(RestaurantEntity());

        when(repository.getRestaurantDetails(query))
            .thenAnswer((_) async => expectedResult);

        final result = await useCase(query);

        expect(result, expectedResult);
        verify(repository.getRestaurantDetails(query)).called(1);
      },
    );
  });
}
