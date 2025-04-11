sealed class RestaurantDetailsEvent {
  const RestaurantDetailsEvent();
}

class GetRestaurantDetailsEvent extends RestaurantDetailsEvent {
  const GetRestaurantDetailsEvent(this.restaurantId);

  final String? restaurantId;
}
