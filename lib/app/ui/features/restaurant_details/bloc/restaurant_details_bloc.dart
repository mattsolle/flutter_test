import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/architecture/failure.dart';
import '../../../../domain/query_entity/get_restaurant_details_query_entity.dart';
import '../../../../domain/use_cases/get_restaurant_details_use_case.dart';
import '../../../utils/extensions/int_extension.dart';
import 'restaurant_details_bloc_events.dart';
import 'restaurant_details_bloc_states.dart';

class RestaurantDetailsBloc
    extends Bloc<RestaurantDetailsEvent, RestaurantDetailsState> {
  RestaurantDetailsBloc(this.getRestaurantDetailsUseCase)
      : super(const RestaurantDetailsLoadingState()) {
    on<GetRestaurantDetailsEvent>(loadRestaurantDetails);
  }

  final GetRestaurantDetailsUseCase getRestaurantDetailsUseCase;

  Future<void> loadRestaurantDetails(
    GetRestaurantDetailsEvent event,
    Emitter emit,
  ) async {
    final id = event.restaurantId;

    if (id == null) {
      emit(const RestaurantDetailsInvalidState());
      return;
    }

    emit(
      const RestaurantDetailsLoadingState(),
    );

    final result = await getRestaurantDetailsUseCase(
      GetRestaurantDetailsQueryEntity(id: id),
    );

    if (result.isSuccess) {
      emit(
        RestaurantDetailsLoadedState(
          result.success,
        ),
      );

      return;
    }

    if (result.failure is RestaurantNotFoundFailure) {
      emit(const RestaurantDetailsInvalidState());
      return;
    }

    emit(
      const RestaurantDetailsErrorState(),
    );

    Error.throwWithStackTrace(result.failure, result.failure.stackTrace);
  }
}
