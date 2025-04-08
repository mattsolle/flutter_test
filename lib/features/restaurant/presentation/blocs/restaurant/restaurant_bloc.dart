import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_tour/core/utils/app_logger.dart';
import '../../../data/models/restaurant.dart';
import '../../../domain/use_cases/fetch_restaurants.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final FetchRestaurants _fetchRestaurants;
  final AppLogger _logger;

  RestaurantBloc(this._fetchRestaurants, this._logger)
      : super(RestaurantInitial()) {
    on<FetchRestaurantsEvent>(_onFetchRestaurants);
  }

  Future<void> _onFetchRestaurants(
    FetchRestaurantsEvent event,
    Emitter<RestaurantState> emit,
  ) async {
    if (state is! RestaurantLoaded) {
      emit(RestaurantLoading());
    }

    try {
      final restaurants = await _fetchRestaurants.execute(event.offset);
      emit(RestaurantLoaded(restaurants));
    } catch (e, stackTrace) {
      _logger.logError(
        "RestaurantBloc Error: $e",
        error: e,
        stackTrace: stackTrace,
      );
      emit(RestaurantError("Failed to fetch restaurants"));
    }
  }
}
