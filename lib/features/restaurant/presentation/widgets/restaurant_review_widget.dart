import 'package:flutter/material.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/restaurant_review_item_widget.dart';

class RestaurantReviewWidget extends StatelessWidget {
  final List<Review> reviews;

  const RestaurantReviewWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Text(
        AppStrings.noReviewsAvailable,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${reviews.length} ${AppStrings.reviews}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Column(
          children: reviews
              .map((review) => RestaurantReviewItemWidget(review: review))
              .toList(),
        ),
      ],
    );
  }
}
