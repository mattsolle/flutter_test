import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_tour/app/domain/architecture/failure.dart';
import 'package:restaurant_tour/app/domain/entities/restaurant_entity.dart';
import 'package:restaurant_tour/app/domain/entities/restaurant_query_result_entity.dart';
import 'package:restaurant_tour/app/domain/query_entity/get_restaurant_details_query_entity.dart';
import 'package:restaurant_tour/app/domain/query_entity/get_restaurants_query_entity.dart';
import 'package:restaurant_tour/app/external/datasources/restaurant_datasource_impl.dart';

import 'restaurant_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Dio>(),
  MockSpec<Response>(),
  MockSpec<GetRestaurantsQueryEntity>(),
  MockSpec<GetRestaurantDetailsQueryEntity>(),
])
void main() {
  group('Unit Test - RestaurantDatasourceImpl', () {
    late RestaurantDatasourceImpl datasource;
    late MockDio dio;
    late MockResponse response;
    late MockGetRestaurantsQueryEntity restaurantsQuery;
    late MockGetRestaurantDetailsQueryEntity detailsQuery;

    setUp(() {
      dio = MockDio();
      response = MockResponse();
      restaurantsQuery = MockGetRestaurantsQueryEntity();
      detailsQuery = MockGetRestaurantDetailsQueryEntity();
      datasource = RestaurantDatasourceImpl(dio);
    });

    test(
      'Given the RestaurantDatasourceImpl, \n'
      'When getRestaurants receives a 200 response with valid data, \n'
      'Then it should return the parsed RestaurantQueryResultEntity',
      () async {
        when(dio.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);
        when(response.statusCode).thenReturn(200);
        when(response.data).thenReturn({
          'data': {
            'search': {
              'business': [],
              'total': 0,
            },
          },
        });

        final result = await datasource.getRestaurants(restaurantsQuery);

        expect(result, isA<RestaurantQueryResultEntity>());
        verify(dio.post('/graphql', data: anyNamed('data'))).called(1);
      },
    );

    test(
      'Given the RestaurantDatasourceImpl, \n'
      'When getRestaurants receives a non-200 response, \n'
      'Then it should throw an UnknownFailure',
      () async {
        when(dio.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);
        when(response.statusCode).thenReturn(500);
        when(response.data).thenReturn({'error': 'Internal Server Error'});

        expect(
          () async => await datasource.getRestaurants(restaurantsQuery),
          throwsA(isA<UnknownFailure>()),
        );
      },
    );

    test(
      'Given the RestaurantDatasourceImpl, \n'
      'When getRestaurants has invalid JSON structure, \n'
      'Then it should throw a SerializationFailure',
      () async {
        when(dio.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);
        when(response.statusCode).thenReturn(200);
        when(response.data).thenReturn({'data': null});

        expect(
          () async => datasource.getRestaurants(restaurantsQuery),
          throwsA(isA<SerializationFailure>()),
        );
      },
    );

    test(
      'Given the RestaurantDatasourceImpl, \n'
      'When getRestaurantDetails receives a 200 response with valid data, \n'
      'Then it should return the parsed RestaurantEntity',
      () async {
        when(dio.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);
        when(response.statusCode).thenReturn(200);
        when(response.data).thenReturn({
          'data': {
            'business': {
              'id': 'abc',
              'name': 'Example Restaurant',
              'categories': [],
            },
          },
        });

        final result = await datasource.getRestaurantDetails(detailsQuery);

        expect(result, isA<RestaurantEntity>());
        verify(dio.post('/graphql', data: anyNamed('data'))).called(1);
      },
    );

    test(
      'Given the RestaurantDatasourceImpl, \n'
      'When getRestaurantDetails receives a non-200 response, \n'
      'Then it should throw an UnknownFailure',
      () async {
        when(dio.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);
        when(response.statusCode).thenReturn(404);
        when(response.data).thenReturn({'message': 'Not Found'});

        expect(
          () async => await datasource.getRestaurantDetails(detailsQuery),
          throwsA(isA<UnknownFailure>()),
        );
      },
    );

    test(
      'Given the RestaurantDatasourceImpl, \n'
      'When getRestaurantDetails has invalid JSON structure, \n'
      'Then it should throw a SerializationFailure',
      () async {
        when(dio.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => response);
        when(response.statusCode).thenReturn(200);
        when(response.data).thenReturn({'data': null});

        expect(
          () async => await datasource.getRestaurantDetails(detailsQuery),
          throwsA(isA<SerializationFailure>()),
        );
      },
    );
  });
}
