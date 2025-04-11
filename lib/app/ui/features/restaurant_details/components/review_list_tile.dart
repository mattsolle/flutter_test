import 'package:flutter/material.dart';

import '../../../design_system/atoms/image_avatar_widget.dart';
import '../../../design_system/atoms/stars_rating_widget.dart';
import '../../../utils/extensions/context_extension.dart';

class ReviewListTile extends StatelessWidget {
  const ReviewListTile({
    super.key,
    required this.rating,
    required this.reviewText,
    required this.userName,
    required this.userImageUrl,
  });

  final num rating;
  final String reviewText;
  final String userName;
  final ImageProvider userImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StarsRatingWidget(
          rating: rating,
          totalStars: 5,
          starColor: context.appColors.ratingStars,
          starSize: 8 * 3 / 2,
        ),
        const SizedBox(height: 8),
        Text(
          reviewText,
          style: context.appTypography.openRegularText,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ImageAvatarWidget(
              image: userImageUrl,
              size: 16 * 5 / 2,
              shape: const CircleBorder(),
            ),
            const SizedBox(width: 8),
            Text(
              userName,
              style: context.appTypography.openRegularText,
            ),
          ],
        ),
      ],
    );
  }
}
