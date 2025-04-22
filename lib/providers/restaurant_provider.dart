import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';
import '../services/restaurant_service.dart';
import '../services/mock_restaurant_service.dart';

// Mock service in development
//final restaurantServiceProvider = Provider((ref) => MockRestaurantService());
final restaurantServiceProvider = Provider((ref) => RestaurantService());

final restaurantsProvider = FutureProvider<RestaurantQueryResult?>((ref) async {
  final service = ref.watch(restaurantServiceProvider);
  return service.getRestaurants();
});

final restaurantProvider = FutureProvider.family<RestaurantQueryResult?, String>((ref, id) async {
  final service = ref.watch(restaurantServiceProvider);
  return service.getRestaurantById(id);
}); 