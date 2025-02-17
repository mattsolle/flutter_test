import 'dart:convert';
import 'dart:developer';

import 'package:core/core.dart';

import '../models/restaurant.dart';
import '../queries/get_restaurant_by_id_query.dart';
import '../queries/get_restaurants_query.dart';

abstract class RestaurantsRepository {
  const RestaurantsRepository();

  Future<(List<Restaurant>, int)> fetchRestaurants({int offset = 0});
  Future<Restaurant?> getRestaurantById(String id);
}

class RestaurantsRepositoryImpl extends RestaurantsRepository {
  const RestaurantsRepositoryImpl({
    required this.httpClient,
  });

  final HttpClient httpClient;

  @override
  Future<(List<Restaurant>, int)> fetchRestaurants({int offset = 0}) async {
    try {
      final request = HttpRequest(
        path: 'https://api.yelp.com/v3/graphql',
        payload: getRestaurantsQuery(offset),
      );

      final response = await httpClient.post(request);

      if (response.dataJson == null) {
        throw Exception('Empty response from Yelp API');
      }

      final Map<String, dynamic> decodedData = jsonDecode(response.dataJson!);

      if (!decodedData.containsKey('data') || decodedData['data'] == null) {
        throw Exception('Invalid response format: missing "data" field');
      }

      final result = RestaurantQueryResult.fromJson(
        decodedData['data']['search'],
      );

      final int total = decodedData['data']['search']['total'];

      return (result.restaurants ?? [], total);
    } catch (error) {
      log('Error fetching restaurants: $error');
      throw Exception('Failed to fetch restaurants');
    }
  }

  @override
  Future<Restaurant?> getRestaurantById(String id) async {
    try {
      final request = HttpRequest(
        path: 'https://api.yelp.com/v3/graphql',
        payload: getRestaurantByIdQuery(id),
      );

      final response = await httpClient.post(request);

      if (response.dataJson == null) {
        throw Exception('Empty response from Yelp API');
      }

      final Map<String, dynamic> decodedData = jsonDecode(response.dataJson!);

      if (!decodedData.containsKey('data') || decodedData['data'] == null) {
        throw Exception('Invalid response format: missing "data" field');
      }

      return Restaurant.fromJson(
        decodedData['data']['business'],
      );
    } catch (error) {
      log('Error getting restaurant ($id): $error');
      throw Exception('Failed to get restaurant');
    }
  }
}
