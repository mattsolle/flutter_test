import 'package:core/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../blocs/restaurants_cubit.dart';
import '../blocs/restaurants_state.dart';
import 'restaurants_screen.dart';

class RestaurantsContainer
    extends BlocBuilder<RestaurantsCubit, RestaurantsState> {
  RestaurantsContainer({super.key})
      : super(
          builder: (context, state) {
            if (state.status == RestaurantsStatus.loading) {
              return const LoadingWidget();
            } else if (state.status == RestaurantsStatus.error) {
              return const Material(
                child: Center(
                  child: Text('error'),
                ),
              );
            } else {
              return RestaurantsScreen(
                controller: state.controller,
              );
            }
          },
        );
}
