import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_tour/app/domain/datasources/restaurant_datasource.dart';
import 'package:restaurant_tour/app/domain/entities/restaurant_entity.dart';
import 'package:restaurant_tour/app/domain/entities/restaurant_query_result_entity.dart';
import 'package:restaurant_tour/app/domain/query_entity/get_restaurant_details_query_entity.dart';
import 'package:restaurant_tour/app/domain/query_entity/get_restaurants_query_entity.dart';
import 'package:restaurant_tour/app/external/repositories/restaurant_repository_impl.dart';

import 'restaurant_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RestaurantDatasource>(),
  MockSpec<GetRestaurantsQueryEntity>(),
  MockSpec<GetRestaurantDetailsQueryEntity>(),
])
void main() {
  group('Unit Test - RestaurantRepositoryImpl', () {
    late RestaurantRepositoryImpl repository;
    late MockRestaurantDatasource datasource;
    late MockGetRestaurantsQueryEntity restaurantsQuery;
    late MockGetRestaurantDetailsQueryEntity detailsQuery;

    setUp(() {
      datasource = MockRestaurantDatasource();
      restaurantsQuery = MockGetRestaurantsQueryEntity();
      detailsQuery = MockGetRestaurantDetailsQueryEntity();
      repository = RestaurantRepositoryImpl(datasource);
    });

    test(
      'Given the RestaurantRepositoryImpl, \n'
      'When getRestaurants is called and datasource succeeds, \n'
      'Then it should return a success Result with the data',
      () async {
        const expected = RestaurantQueryResultEntity();
        when(datasource.getRestaurants(restaurantsQuery))
            .thenAnswer((_) async => expected);

        final result = await repository.getRestaurants(restaurantsQuery);

        expect(result.isSuccess, true);
        expect(result.success, expected);
        verify(datasource.getRestaurants(restaurantsQuery)).called(1);
      },
    );

    test(
      'Given the RestaurantRepositoryImpl, \n'
      'When getRestaurants is called and datasource throws, \n'
      'Then it should return a failure Result',
      () async {
        when(datasource.getRestaurants(restaurantsQuery))
            .thenThrow(Exception('error'));

        final result = await repository.getRestaurants(restaurantsQuery);

        expect(result.isFailure, true);
        verify(datasource.getRestaurants(restaurantsQuery)).called(1);
      },
    );

    test(
      'Given the RestaurantRepositoryImpl, \n'
      'When getRestaurantDetails is called and datasource succeeds, \n'
      'Then it should return a success Result with the data',
      () async {
        const expected = RestaurantEntity();
        when(datasource.getRestaurantDetails(detailsQuery))
            .thenAnswer((_) async => expected);

        final result = await repository.getRestaurantDetails(detailsQuery);

        expect(result.isSuccess, true);
        expect(result.success, expected);
        verify(datasource.getRestaurantDetails(detailsQuery)).called(1);
      },
    );

    test(
      'Given the RestaurantRepositoryImpl, \n'
      'When getRestaurantDetails is called and datasource throws, \n'
      'Then it should return a failure Result',
      () async {
        when(datasource.getRestaurantDetails(detailsQuery))
            .thenThrow(Exception('failure'));

        final result = await repository.getRestaurantDetails(detailsQuery);

        expect(result.isFailure, true);
        verify(datasource.getRestaurantDetails(detailsQuery)).called(1);
      },
    );
  });
}
