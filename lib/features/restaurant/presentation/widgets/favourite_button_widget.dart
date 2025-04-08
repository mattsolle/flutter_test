import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_tour/core/constants/app_icons.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';

import '../cubits/favourite_restaurants/favourite_restaurants_cubit.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteButtonWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteRestaurantsCubit, FavoriteRestaurantsState>(
      builder: (context, state) {
        bool isFavorite = (state is FavoriteRestaurantsLoaded &&
            state.favorites.any((r) => r.id == restaurant.id));

        return IconButton(
          icon: Icon(
            isFavorite ? AppIcons.favorite : AppIcons.favoriteBorder,
          ),
          onPressed: () {
            context
                .read<FavoriteRestaurantsCubit>()
                .toggleFavoriteRestaurant(restaurant);
          },
        );
      },
    );
  }
}
