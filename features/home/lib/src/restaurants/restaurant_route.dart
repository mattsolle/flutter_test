import 'dart:developer';

import 'package:core/core.dart';
import 'package:core/go_router.dart';

import 'data/models/restaurant.dart';
import 'widgets/restaurant_screen.dart';

class RestaurantRoute extends GoRoute {
  RestaurantRoute()
      : super(
          name: RouteNames.restaurant,
          path: 'restaurant',
          builder: (context, state) {
            final restaurant = state.extra as Restaurant;
            return RestaurantScreen(
              restaurant: restaurant,
              onBackPressed: context.pop,
              onLikePressed: () {
                log('TODO: onLikePressed');
              },
            );
          },
        );
}
