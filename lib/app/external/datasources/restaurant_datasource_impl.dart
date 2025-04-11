import 'package:dio/dio.dart';

import '../../domain/architecture/failure.dart';
import '../../domain/datasources/restaurant_datasource.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/entities/restaurant_query_result_entity.dart';
import '../../domain/query_entity/get_restaurant_details_query_entity.dart';
import '../../domain/query_entity/get_restaurants_query_entity.dart';
import '../models/restaurant_model.dart';
import '../models/restaurant_query_result_model.dart';
import '../query_models/get_restaurant_details_query_model.dart';
import '../query_models/get_restaurants_query_model.dart';

class RestaurantDatasourceImpl implements RestaurantDatasource {
  const RestaurantDatasourceImpl(this.dio);

  final Dio dio;

  @override
  Future<RestaurantQueryResultEntity> getRestaurants(
    GetRestaurantsQueryEntity query,
  ) async {
    final model = GetRestaurantsQueryModel.fromEntity(query);

    final response = await dio.post(
      '/graphql',
      data: model.toQuery(),
    );

    if (response.statusCode != 200) {
      throw UnknownFailure(response.data, StackTrace.current);
    }

    try {
      final model = RestaurantQueryResultModel.fromJson(
        response.data['data']['search'],
      );

      return model.toEntity();
    } catch (e, s) {
      throw SerializationFailure(e, s);
    }
  }

  @override
  Future<RestaurantEntity> getRestaurantDetails(
    GetRestaurantDetailsQueryEntity query,
  ) async {
    final model = GetRestaurantDetailsQueryModel.fromEntity(query);

    final response = await dio.post(
      '/graphql',
      data: model.toQuery(),
    );

    if (response.statusCode != 200) {
      throw UnknownFailure(response.data, StackTrace.current);
    }

    try {
      final model = RestaurantModel.fromJson(
        response.data['data']['business'],
      );

      return model.toEntity();
    } catch (e, s) {
      throw SerializationFailure(e, s);
    }
  }
}
