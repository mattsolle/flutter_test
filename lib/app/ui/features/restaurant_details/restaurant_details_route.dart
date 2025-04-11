import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../app/app_router.dart';
import 'bloc/restaurant_details_bloc.dart';
import 'pages/restaurant_details_page.dart';

class RestaurantDetails {
  RestaurantDetails(this.i);

  final GetIt i;

  late final GoRoute route = GoRoute(
    path: '${AppRouter.restaurantDetails}/:id',
    name: AppRouter.restaurantDetails,
    builder: builder,
  );

  late final bloc = RestaurantDetailsBloc(i());

  Widget builder(BuildContext context, GoRouterState state) {
    final id = state.pathParameters['id'];

    return RestaurantDetailsPage(
      restaurantId: id,
      bloc: bloc,
    );
  }
}
