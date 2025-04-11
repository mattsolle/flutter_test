import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/query_entity/get_restaurants_query_entity.dart';
import '../../../../domain/use_cases/get_restaurants_use_case.dart';
import 'restaurant_list_bloc_events.dart';
import 'restaurant_list_bloc_states.dart';

class RestaurantListBloc
    extends Bloc<RestaurantListBlocEvent, RestaurantListBlocState> {
  RestaurantListBloc(this.getRestaurantsUseCase)
      : super(const LoadingRestaurantListState()) {
    on<GetRestaurantsEvent>(
      loadFavoritesRestaurants,
    );
  }

  final GetRestaurantsUseCase getRestaurantsUseCase;

  Future<void> loadFavoritesRestaurants(
    GetRestaurantsEvent event,
    Emitter emitter,
  ) async {
    late final RestaurantListBlocState loadingState;

    if (event.mostReload || state is! LoadedRestaurantListState) {
      loadingState = const LoadingRestaurantListState();
    } else {
      final currentState = state as LoadedRestaurantListState;

      loadingState = currentState.copyWith(
        isLoadingMore: true,
      );
    }

    emitter(loadingState);

    final result = await getRestaurantsUseCase(
      GetRestaurantsQueryEntity(
        offset: event.offset,
        favorites: event.favorites,
      ),
    );

    if (result.isSuccess) {
      emitter(
        LoadedRestaurantListState(
          result.success,
          false,
        ),
      );

      return;
    }

    emitter(
      const ErrorRestaurantListState(),
    );

    Error.throwWithStackTrace(result.failure, result.failure.stackTrace);
  }
}
