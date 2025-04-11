import '../../../../domain/entities/restaurant_query_result_entity.dart';

sealed class RestaurantListBlocState {
  const RestaurantListBlocState();
}

class LoadingRestaurantListState extends RestaurantListBlocState {
  const LoadingRestaurantListState();
}

class LoadedRestaurantListState extends RestaurantListBlocState {
  const LoadedRestaurantListState(
    this.result,
    this.isLoadingMore,
  );

  final bool isLoadingMore;
  final RestaurantQueryResultEntity result;

  LoadedRestaurantListState copyWith({
    RestaurantQueryResultEntity? result,
    bool? isLoadingMore,
  }) {
    return LoadedRestaurantListState(
      result ?? this.result,
      isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class ErrorRestaurantListState extends RestaurantListBlocState {
  const ErrorRestaurantListState();
}
