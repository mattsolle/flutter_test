import 'package:flutter/material.dart';
import 'package:restaurant_tour/core/constants/app_colors.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';

class RestaurantStatusWidget extends StatelessWidget {
  final bool isOpen;

  const RestaurantStatusWidget({super.key, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          isOpen ? AppStrings.openNow : AppStrings.closed,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(width: 8.0),
        CircleAvatar(
          radius: 5,
          backgroundColor:
              isOpen ? AppColors.openStatus : AppColors.closedStatus,
        ),
      ],
    );
  }
}
