import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../widgets/open_status_widget.dart';
import '../../widgets/price_category_widget.dart';
import '../data/models/restaurant.dart';
import 'image_error.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({
    super.key,
    required this.restaurant,
    required this.onBackPressed,
    required this.onLikePressed,
  });

  final Restaurant restaurant;
  final VoidCallback onBackPressed;
  final VoidCallback onLikePressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name ?? 'Restaurant'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: onLikePressed,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (restaurant.photos != null && restaurant.photos!.isNotEmpty)
              AspectRatio(
                aspectRatio: 1,
                child: PageView.builder(
                  itemCount: restaurant.photos!.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: restaurant.photos![index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const LoadingWidget(),
                      errorWidget: (context, url, error) => const ImageError(),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: x4, horizontal: x4),
              child: Row(
                children: [
                  if (restaurant.price != null ||
                      restaurant.categories?.first != null)
                    PriceCategoryWidget(
                      price: restaurant.price,
                      category: restaurant.categories?.first.title,
                    ),
                  const Spacer(),
                  OpenStatusWidget(isOpen: restaurant.isOpen),
                ],
              ),
            ),
            const _Padding(
              child: Divider(height: 1),
            ),
            if (restaurant.location != null &&
                restaurant.location?.formattedAddress != null)
              _Item(
                title: 'Address',
                child: Text(
                  restaurant.location!.formattedAddress!,
                  style: AppTextStyles.openRegularTitleSemiBold,
                ),
              ),
            const _Padding(
              child: Divider(height: 1),
            ),
            if (restaurant.rating != null)
              _Item(
                title: 'Overall Rating',
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      restaurant.rating!.toString(),
                      style: AppTextStyles.loraRegularBigHeadline,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: x2),
                      child: Icon(
                        Icons.star,
                        size: x4,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            const _Padding(
              child: Divider(height: 1),
            ),
            if (restaurant.reviews != null && restaurant.reviews!.isNotEmpty)
              _Item(
                title: '${restaurant.reviews!.length} Reviews',
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: restaurant.reviews!.length,
                  separatorBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: x4),
                    child: Divider(height: 1),
                  ),
                  itemBuilder: (context, index) {
                    final review = restaurant.reviews![index];
                    return _ReviewItem(review: review);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem({
    required this.review,
  });

  final Review review;

  bool isImageUrlValid(String? url) {
    return url != null && Uri.tryParse(url)?.hasAbsolutePath == true;
  }

  @override
  Widget build(BuildContext context) {
    const userImageSize = 40.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (review.rating != null)
          Padding(
            padding: const EdgeInsets.only(bottom: x2),
            child: RatingBarIndicator(
              rating: review.rating!.toDouble(),
              itemCount: 5,
              itemSize: 20,
              unratedColor: Colors.transparent,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
          ),
        Text(
          review.text ?? '',
          style: AppTextStyles.openRegularHeadline,
        ),
        if (review.user != null)
          if (review.user!.imageUrl == null)
            _User(
              name: review.user!.name ?? '',
              child: const ImageError(
                size: userImageSize,
                isCircular: true,
              ),
            )
          else
            isImageUrlValid(review.user?.imageUrl)
                ? _User(
                    name: review.user!.name ?? '',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(x20),
                      child: CachedNetworkImage(
                        imageUrl: review.user!.imageUrl!,
                        height: userImageSize,
                        width: userImageSize,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const LoadingWidget(),
                        errorWidget: (context, url, error) {
                          return const ImageError(
                            size: userImageSize,
                            isCircular: true,
                          );
                        },
                      ),
                    ),
                  )
                : _User(
                    name: review.user!.name ?? '',
                    child: const ImageError(
                      size: userImageSize,
                      isCircular: true,
                    ),
                  ),
      ],
    );
  }
}

class _User extends StatelessWidget {
  const _User({
    required this.name,
    required this.child,
  });

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: x2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          const SizedBox(width: x2),
          Text(
            name,
            style: AppTextStyles.openRegularText,
          ),
        ],
      ),
    );
  }
}

class _Padding extends Padding {
  const _Padding({
    required Widget child,
  }) : super(
          padding: const EdgeInsets.only(
            left: x4,
            right: x4,
            bottom: x4,
          ),
          child: child,
        );
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.openRegularText,
          ),
          const SizedBox(height: x4),
          child,
        ],
      ),
    );
  }
}
