import '../../../../domain/entities/restaurant_entity.dart';

sealed class RestaurantDetailsState {
  const RestaurantDetailsState();
}

class RestaurantDetailsLoadingState extends RestaurantDetailsState {
  const RestaurantDetailsLoadingState();
}

class RestaurantDetailsLoadedState extends RestaurantDetailsState {
  const RestaurantDetailsLoadedState(this.restaurantDetails);

  final RestaurantEntity restaurantDetails;
}

class RestaurantDetailsErrorState extends RestaurantDetailsState {
  const RestaurantDetailsErrorState();
}

class RestaurantDetailsInvalidState extends RestaurantDetailsState {
  const RestaurantDetailsInvalidState();
}
