import 'package:flutter/material.dart';
import 'package:restaurant_tour/core/constants/app_icons.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/cached_network_image_widget.dart';

class RestaurantReviewItemWidget extends StatelessWidget {
  final Review review;

  const RestaurantReviewItemWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              review.rating?.round() ?? 0,
              (index) => const Icon(
                AppIcons.star,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            review.text ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CachedNetworkImageWidget(
                    imgUrl: review.user?.imageUrl ?? "",
                    imgWidth: 40,
                    imgHeight: 40,
                    boxFit: BoxFit.cover,
                    heroTag: null,
                    errorWidget: const Icon(AppIcons.user),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  review.user?.name ?? AppStrings.anonymous,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
