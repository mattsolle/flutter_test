import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_tour/core/constants/app_icons.dart';
import 'package:restaurant_tour/core/routes/app_routes.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/cached_network_image_widget.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/restaurant_status_widget.dart';

class RestaurantListItemWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantListItemWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoutes.restaurantDetails.name,
          extra: restaurant,
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImageWidget(
                imgUrl: restaurant.heroImage,
                imgWidth: 88,
                imgHeight: 88,
                heroTag: "restaurant_${restaurant.id}",
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name ?? "Restaurant Name",
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${restaurant.price ?? "\$\$"} ${restaurant.displayCategory}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: List.generate(
                                restaurant.rating?.round() ?? 0,
                                (index) => const Icon(
                                  AppIcons.star,
                                  size: 14,
                                ),
                              ),
                            ),
                            RestaurantStatusWidget(isOpen: restaurant.isOpen),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
