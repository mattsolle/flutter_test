part of 'favourite_restaurants_cubit.dart';

sealed class FavoriteRestaurantsState extends Equatable {
  const FavoriteRestaurantsState();

  @override
  List<Object?> get props => [];
}

final class FavoriteRestaurantsInitial extends FavoriteRestaurantsState {}

final class FavoriteRestaurantsLoaded extends FavoriteRestaurantsState {
  final List<Restaurant> favorites;

  const FavoriteRestaurantsLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

final class FavoriteRestaurantsError extends FavoriteRestaurantsState {
  final String message;

  const FavoriteRestaurantsError(this.message);

  @override
  List<Object?> get props => [message];
}
