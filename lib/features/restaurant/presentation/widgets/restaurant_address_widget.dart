import 'package:flutter/material.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';

class RestaurantAddressWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantAddressWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.address,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        Text(
          restaurant.location?.formattedAddress ??
              AppStrings.noAddressAvailable,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
