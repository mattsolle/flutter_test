import '../../data/models/restaurant.dart';
import '../repositories/restaurant_repository.dart';

class FetchRestaurants {
  final RestaurantRepository repository;

  FetchRestaurants(this.repository);

  Future<List<Restaurant>> execute(int offset) {
    return repository.fetchRestaurants(offset);
  }
}
