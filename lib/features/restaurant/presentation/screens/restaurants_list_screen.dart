import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import '../blocs/restaurant/restaurant_bloc.dart';
import '../widgets/restaurants_list.dart';

class RestaurantsListScreen extends StatelessWidget {
  const RestaurantsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RestaurantLoaded) {
          return RestaurantList(restaurants: state.restaurants);
        } else if (state is RestaurantError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text(AppStrings.noDataAvailable));
      },
    );
  }
}
