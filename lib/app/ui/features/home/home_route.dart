import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../app/app_router.dart';
import 'bloc/restaurant_list_bloc.dart';
import 'home_page.dart';

class HomeRoute {
  HomeRoute(this.i);

  final GetIt i;

  late final GoRoute route = GoRoute(
    path: AppRouter.home,
    builder: builder,
  );

  late final RestaurantListBloc restaurantListBloc = RestaurantListBloc(
    i(),
  );

  Widget builder(BuildContext context, GoRouterState state) {
    return HomePage(
      restaurantListBloc: restaurantListBloc,
    );
  }
}
