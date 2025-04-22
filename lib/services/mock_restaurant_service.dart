import '../models/restaurant.dart';
import '../mock_data/restaurants.dart';

class MockRestaurantService {
  Future<RestaurantQueryResult?> getRestaurants({int offset = 0}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return mockRestaurantResult;
  }

  Future<RestaurantQueryResult?> getRestaurantById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final restaurant = mockRestaurants.firstWhere(
      (r) => r.id == id,
      orElse: () => mockRestaurants.first,
    );

    return RestaurantQueryResult(
      total: 1,
      restaurants: [restaurant],
    );
  }
} 