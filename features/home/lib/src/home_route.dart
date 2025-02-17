import 'package:core/core.dart';
import 'package:core/go_router.dart';

import 'restaurants/restaurant_route.dart';
import 'widgets/home_screen.dart';

class HomeRoute extends GoRoute {
  HomeRoute()
      : super(
          name: RouteNames.home,
          path: '/home',
          builder: (context, state) {
            return const HomeScreen();
          },
          routes: [
            RestaurantRoute(),
          ],
        );
}
