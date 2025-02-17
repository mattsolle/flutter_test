import 'package:core/core.dart';
import 'package:core/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/repositories/restaurants_repository.dart';
import 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit({
    required this.repository,
  }) : super(
          RestaurantsState(
            status: RestaurantsStatus.loading,
            controller: PagingController(firstPageKey: 0),
          ),
        ) {
    state.controller.addPageRequestListener(_fetchPage);
    _fetchPage(0);
  }

  final RestaurantsRepository repository;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final (restaurants, total) = await repository.fetchRestaurants(
        offset: state.offset,
      );
      final offset = state.offset + restaurants.length;
      final isLastPage = offset >= total;

      if (isLastPage) {
        state.controller.appendLastPage(restaurants);
      } else {
        pageKey++;
        state.controller.appendPage(restaurants, pageKey);
      }

      emit(
        state.copyWith(
          status: RestaurantsStatus.success,
          offset: offset,
        ),
      );
    } catch (error) {
      if (state.controller.itemList?.isNotEmpty == true) {
        state.controller.error = error;
      } else {
        emit(state.copyWith(status: RestaurantsStatus.error));
      }
    }
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}

class RestaurantsCubitProvider extends BlocProvider<RestaurantsCubit> {
  RestaurantsCubitProvider({
    super.key,
    super.child,
  }) : super(
          create: (context) => RestaurantsCubit(
            repository: di(),
          ),
        );
}
