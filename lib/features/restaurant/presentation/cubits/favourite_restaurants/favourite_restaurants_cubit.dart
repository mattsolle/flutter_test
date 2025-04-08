import 'package:equatable/equatable.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'favourite_restaurants_state.dart';

class FavoriteRestaurantsCubit extends HydratedCubit<FavoriteRestaurantsState> {
  FavoriteRestaurantsCubit() : super(const FavoriteRestaurantsLoaded([]));

  void toggleFavoriteRestaurant(Restaurant restaurant) {
    if (state is FavoriteRestaurantsLoaded) {
      final List<Restaurant> updatedFavorites =
          List.from((state as FavoriteRestaurantsLoaded).favorites);
      final isFavorite = updatedFavorites.any((r) => r.id == restaurant.id);

      if (isFavorite) {
        updatedFavorites.removeWhere((r) => r.id == restaurant.id);
      } else {
        updatedFavorites.add(restaurant);
      }

      emit(FavoriteRestaurantsLoaded(updatedFavorites));
    } else {
      emit(FavoriteRestaurantsLoaded([restaurant]));
    }
  }

  bool isFavoriteRestaurant(Restaurant restaurant) {
    if (state is FavoriteRestaurantsLoaded) {
      return (state as FavoriteRestaurantsLoaded)
          .favorites
          .any((r) => r.id == restaurant.id);
    }
    return false;
  }

  @override
  FavoriteRestaurantsState fromJson(Map<String, dynamic> json) {
    try {
      final favoritesList = (json['favorites'] as List)
          .map((e) => Restaurant.fromJson(e))
          .toList();
      return FavoriteRestaurantsLoaded(favoritesList);
    } catch (e) {
      return const FavoriteRestaurantsLoaded([]);
    }
  }

  @override
  Map<String, dynamic> toJson(FavoriteRestaurantsState state) {
    if (state is FavoriteRestaurantsLoaded) {
      return {'favorites': state.favorites.map((r) => r.toJson()).toList()};
    }
    return {};
  }
}
