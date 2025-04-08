part of 'restaurant_bloc.dart';

sealed class RestaurantEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRestaurantsEvent extends RestaurantEvent {
  final int offset;
  FetchRestaurantsEvent(this.offset);
}
