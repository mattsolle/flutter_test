import 'package:core/core.dart';
import 'package:core/flutter_bloc.dart';
import 'package:core/go_router.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../blocs/bookmarked_restaurants_cubit.dart';
import '../blocs/bookmarked_restaurants_state.dart';
import 'restaurants_screen.dart';

class BookmarkedRestaurantsContainer extends BlocBuilder<
    BookmarkedRestaurantsCubit, BookmarkedRestaurantsState> {
  BookmarkedRestaurantsContainer({
    super.key,
  }) : super(
          builder: (context, state) {
            void refresh() {
              context.read<BookmarkedRestaurantsCubit>().fetchRestaurants();
            }

            if (state.status == BookmarkedRestaurantsStatus.loading) {
              return const LoadingWidget();
            } else if (state.status == BookmarkedRestaurantsStatus.error) {
              return const Material(
                child: Center(
                  child: Text('error'),
                ),
              );
            } else if (state.status == BookmarkedRestaurantsStatus.empty) {
              return const Material(
                child: Center(
                  child: Text('vazio'),
                ),
              );
            } else {
              return RestaurantsScreen(
                controller: PagingController(firstPageKey: 0)
                  ..appendLastPage(state.restaurants),
                onRestaurantPressed: (restaurant) {
                  context
                      .pushNamed(RouteNames.restaurant, extra: restaurant)
                      .then((_) => refresh());
                },
              );
            }
          },
        );
}
