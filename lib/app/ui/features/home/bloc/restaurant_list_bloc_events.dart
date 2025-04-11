sealed class RestaurantListBlocEvent {
  const RestaurantListBlocEvent();
}

class GetRestaurantsEvent extends RestaurantListBlocEvent {
  const GetRestaurantsEvent({
    required this.offset,
    required this.favorites,
  });

  final int offset;
  final bool favorites;

  bool get mostReload => offset == 0;
}
