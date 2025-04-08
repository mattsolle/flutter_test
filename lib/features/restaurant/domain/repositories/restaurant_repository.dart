import '../../data/models/restaurant.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> fetchRestaurants(int offset);
}
