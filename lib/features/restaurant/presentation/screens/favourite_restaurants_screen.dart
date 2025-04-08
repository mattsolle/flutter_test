import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_tour/core/constants/app_colors.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/restaurant_list_item_widget.dart';
import '../cubits/favourite_restaurants/favourite_restaurants_cubit.dart';

class FavoriteRestaurantsScreen extends StatelessWidget {
  const FavoriteRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteRestaurantsCubit, FavoriteRestaurantsState>(
      builder: (context, state) {
        switch (state) {
          case FavoriteRestaurantsInitial():
            return const Center(child: CircularProgressIndicator());

          case FavoriteRestaurantsLoaded():
            if (state.favorites.isEmpty) {
              return Center(
                child: Text(
                  AppStrings.noFavouriteRestaurants,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                return RestaurantListItemWidget(
                  restaurant: state.favorites[index],
                );
              },
            );

          case FavoriteRestaurantsError():
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.error,
                    ),
              ),
            );
        }
      },
    );
  }
}
