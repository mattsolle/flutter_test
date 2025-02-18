import 'package:equatable/equatable.dart';

import '../data/models/restaurant.dart';

enum BookmarkedRestaurantsStatus {
  idle,
  loading,
  success,
  empty,
  error,
  yelpLimit
}

class BookmarkedRestaurantsState extends Equatable {
  const BookmarkedRestaurantsState({
    required this.status,
    this.restaurants = const [],
  });

  final BookmarkedRestaurantsStatus status;
  final List<Restaurant> restaurants;

  @override
  List get props => [status, restaurants, DateTime.now().toIso8601String()];

  BookmarkedRestaurantsState copyWith({
    BookmarkedRestaurantsStatus? status,
    List<Restaurant>? restaurants,
  }) {
    return BookmarkedRestaurantsState(
      status: status ?? this.status,
      restaurants: restaurants ?? this.restaurants,
    );
  }
}
