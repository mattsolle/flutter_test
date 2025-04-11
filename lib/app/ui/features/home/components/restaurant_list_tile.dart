import 'package:flutter/material.dart';

import '../../../design_system/atoms/image_avatar_widget.dart';
import '../../../design_system/atoms/open_status_widget.dart';
import '../../../design_system/atoms/restaurant_price_and_categories_widget.dart';
import '../../../design_system/atoms/stars_rating_widget.dart';
import '../../../utils/extensions/context_extension.dart';

class RestaurantListTileWidget extends StatelessWidget {
  const RestaurantListTileWidget({
    super.key,
    required this.image,
    required this.name,
    this.rating,
    this.price,
    this.isOpen = false,
    this.tags,
    this.onTap,
  });

  final ImageProvider image;
  final String name;
  final double? rating;
  final String? price;
  final bool isOpen;
  final List<String>? tags;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 16 * 6 + 8 + 10,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ImageAvatarWidget(
                  image: image,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  size: 16 * 6,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        style: context.appTypography.loraRegularTitle,
                      ),
                      SizedBox(
                        height: 16 * 2,
                        child: RestaurantPriceAndTagsWidget(
                          price: price ?? '',
                          tags: tags ?? [],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (rating != null)
                            StarsRatingWidget(
                              rating: rating!,
                              totalStars: 5,
                              starColor: Colors.amber,
                              starSize: 12,
                            ),
                          OpenStatusWidget(
                            isOpen: isOpen,
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
      ),
    );
  }
}
