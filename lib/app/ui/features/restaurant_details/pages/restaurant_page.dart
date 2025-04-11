import 'package:flutter/material.dart';

import '../../../../domain/entities/restaurant_entity.dart';
import '../../../design_system/atoms/open_status_widget.dart';
import '../../../design_system/atoms/restaurant_price_and_categories_widget.dart';
import '../../../utils/extensions/app_localization_extension.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/image_provider_extension.dart';
import '../components/review_list_tile.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({
    super.key,
    required this.restaurantEntity,
    required this.isFavorite,
    required this.onTapFavorite,
  });

  final RestaurantEntity restaurantEntity;
  final bool isFavorite;
  final VoidCallback onTapFavorite;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 16);

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantEntity.name ?? ''),
        actions: [
          IconButton(
            onPressed: onTapFavorite,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image:
                      restaurantEntity.heroImage.toImageProvider.orDefaultImage,
                  height: 16 * 16,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RestaurantPriceAndTagsWidget(
                        price: restaurantEntity.price ?? '',
                        tags: restaurantEntity.categories
                                ?.map((e) => e.title ?? '')
                                .toList() ??
                            [],
                      ),
                      OpenStatusWidget(
                        isOpen:
                            restaurantEntity.hours?.firstOrNull?.isOpenNow ??
                                false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: padding,
                  child: Divider(),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.address,
                        style: context.appTypography.openRegularText,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        restaurantEntity.location?.formattedAddress ?? '',
                        style: context.appTypography.openRegularTitleSemiBold,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: padding,
                  child: Divider(),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.overallRating,
                        style: context.appTypography.openRegularText,
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Text(
                            restaurantEntity.rating?.toString() ?? '',
                            style: context.appTypography.loraRegularHeadline,
                          ),
                          Icon(
                            Icons.star,
                            color: context.appColors.ratingStars,
                            size: 8 * 3 / 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: padding,
                  child: Divider(),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: padding,
                  child: Text(
                    context.l10n
                        .xReviews(restaurantEntity.reviews?.length ?? 0),
                    style: context.appTypography.openRegularText,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          SliverPadding(
            padding: padding.copyWith(
              bottom: 16 * 4,
            ),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: restaurantEntity.reviews?.length ?? 0,
              itemBuilder: (context, index) {
                final review = restaurantEntity.reviews?[index];

                if (review == null) {
                  return null;
                }

                return ReviewListTile(
                  rating: review.rating ?? 0,
                  reviewText: review.text ?? '',
                  userName: review.user?.name ?? '',
                  userImageUrl: (review.user?.imageUrl ?? '')
                      .toImageProvider
                      .orDefaultImage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
