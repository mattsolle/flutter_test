import 'package:core/core.dart';
import 'package:core/go_router.dart';

import '../bookmarks/blocs/bookmarks_bloc.dart';
import 'data/models/restaurant.dart';
import 'widgets/restaurant_container.dart';

class RestaurantRoute extends GoRoute {
  RestaurantRoute()
      : super(
          name: RouteNames.restaurant,
          path: 'restaurant',
          builder: (context, state) {
            final restaurant = state.extra as Restaurant;
            return BookmarksBlocProvider(
              child: RestaurantContainer(
                restaurant: restaurant,
              ),
            );
          },
        );
}
