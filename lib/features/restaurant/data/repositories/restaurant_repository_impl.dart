import '../graphql/query.dart';
import '../models/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../static/restaurant_mock_data.dart';
import 'package:restaurant_tour/core/utils/app_logger.dart';
import 'package:restaurant_tour/core/network/api_client.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final ApiClient _apiClient;
  final AppLogger _logger;

  RestaurantRepositoryImpl(this._apiClient, this._logger);

  @override
  Future<List<Restaurant>> fetchRestaurants(int offset) async {
    try {
      final response = await _apiClient.postRequest(query(offset));

      // Check if the API returned an error
      if (response.containsKey('errors')) {
        final errorMessage =
            response['errors'][0]['message'] ?? 'Unknown GraphQL error';
        throw Exception("GraphQL Error: $errorMessage");
      }

      // Ensure response contains expected structure
      if (!response.containsKey('data') ||
          !response['data'].containsKey('search')) {
        throw Exception("Invalid API response: Missing 'search' key");
      }

      List<dynamic> data = response['data']['search']['business'];
      return data.map((json) => Restaurant.fromJson(json)).toList();
      // return _fetchMockRestaurants();
    } catch (e, stackTrace) {
      _logger.logError("HTTP Error: $e", error: e, stackTrace: stackTrace);
      return _fetchMockRestaurants();
    }
  }

  /// Load static mock data if API request fails
  List<Restaurant> _fetchMockRestaurants() {
    _logger.logInfo("Using static data due to API failure.");
    List<dynamic> data = mockRestaurantResponse['data']['search']['business'];
    return data.map((json) => Restaurant.fromJson(json)).toList();
  }
}
