import 'package:flutter/material.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/restaurant_list_item_widget.dart';

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;

  const RestaurantList({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) => RestaurantListItemWidget(
        key: Key('restaurant_item_$index'),
        restaurant: restaurants[index],
      ),
    );
  }
}
