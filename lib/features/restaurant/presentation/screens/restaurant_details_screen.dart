import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_tour/core/constants/app_icons.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/core/theme/typography.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/cached_network_image_widget.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/favourite_button_widget.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/restaurant_status_widget.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/restaurant_address_widget.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/restaurant_review_widget.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(AppIcons.chevronBack),
          onPressed: () => context.pop(),
        ),
        title: Text(
          restaurant.name ?? AppStrings.restaurantDetails,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          Flexible(child: FavoriteButtonWidget(restaurant: restaurant)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "restaurant_${restaurant.id}",
              child: CachedNetworkImageWidget(
                imgUrl: restaurant.heroImage,
                imgHeight: MediaQuery.sizeOf(context).width * 0.6,
                imgWidth: double.infinity,
                boxFit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${restaurant.price ?? ""} ${restaurant.displayCategory}",
                        style: AppTextStyles.openRegularTitle,
                      ),
                      RestaurantStatusWidget(isOpen: restaurant.isOpen),
                    ],
                  ),
                  const Divider(height: 48),
                  RestaurantAddressWidget(restaurant: restaurant),
                  const Divider(height: 48),
                  Text(
                    AppStrings.overallRating,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        restaurant.rating?.toString() ??
                            AppStrings.notAvailable,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(width: 4),
                      const Icon(AppIcons.star, size: 14),
                    ],
                  ),
                  const Divider(height: 48),
                  RestaurantReviewWidget(reviews: restaurant.reviews ?? []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
