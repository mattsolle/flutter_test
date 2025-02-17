import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../widgets/open_status_widget.dart';
import '../../widgets/price_category_widget.dart';
import '../data/models/restaurant.dart';
import 'image_error.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({
    super.key,
    required this.controller,
    required this.onRestaurantPressed,
  });

  final PagingController<int, Restaurant> controller;
  final ValueChanged<Restaurant> onRestaurantPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(x2),
      child: PagedListView.separated(
        pagingController: controller,
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.only(bottom: x2),
        ),
        builderDelegate: PagedChildBuilderDelegate<Restaurant>(
          noItemsFoundIndicatorBuilder: (context) {
            return const Center(
              child: Text('No items found'),
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return const LoadingWidget();
          },
          newPageErrorIndicatorBuilder: (context) {
            return const Center(
              child: Text('New Page Error'),
            );
          },
          itemBuilder: (context, restaurant, index) {
            return _RestaurantItem(
              restaurant: restaurant,
              onPressed: () => onRestaurantPressed(restaurant),
            );
          },
        ),
      ),
    );
  }
}

class _RestaurantItem extends StatelessWidget {
  const _RestaurantItem({
    required this.restaurant,
    required this.onPressed,
  });

  final Restaurant restaurant;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        elevation: x1,
        child: SizedBox(
          height: 104,
          width: double.maxFinite,
          child: Row(
            children: [
              _RestaurantPhoto(
                photoUrl: restaurant.photos?.first,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: x2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.name ?? 'Restaurant Name',
                          style: AppTextStyles.loraRegularTitle,
                        ),
                      ),
                      if (restaurant.price != null ||
                          restaurant.categories?.first != null)
                        PriceCategoryWidget(
                          price: restaurant.price,
                          category: restaurant.categories?.first.title,
                        ),
                      _Rating(
                        rating: restaurant.rating,
                        isOpen: restaurant.isOpen,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RestaurantPhoto extends StatelessWidget {
  const _RestaurantPhoto({
    required this.photoUrl,
  });

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    if (photoUrl == null) {
      return const ImageError();
    } else {
      return Padding(
        padding: const EdgeInsets.all(x2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(x2),
          child: AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: photoUrl!,
              fit: BoxFit.cover,
              errorListener: (_) {},
              placeholder: (context, url) => const LoadingWidget(),
              errorWidget: (context, url, error) => const ImageError(),
            ),
          ),
        ),
      );
    }
  }
}

class _Rating extends StatelessWidget {
  const _Rating({
    required this.rating,
    required this.isOpen,
  });

  final double? rating;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: x3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (rating != null)
            RatingBarIndicator(
              rating: rating!,
              itemCount: 5,
              itemSize: 20,
              unratedColor: Colors.transparent,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
          OpenStatusWidget(isOpen: isOpen),
        ],
      ),
    );
  }
}
