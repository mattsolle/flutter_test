import 'package:flutter/material.dart';

class StarsRatingWidget extends StatelessWidget {
  const StarsRatingWidget({
    super.key,
    required this.rating,
    required this.totalStars,
    required this.starColor,
    this.starSize,
  });

  final num rating;
  final int totalStars;
  final Color starColor;
  final double? starSize;

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final halfStars = (rating - fullStars).round();

    final starts = List.generate(5, (index) {
      if (index < fullStars) {
        return Icons.star;
      }

      if (index < fullStars + halfStars) {
        return Icons.star_half;
      }

      return Icons.star_border;
    });

    return Row(
      children: starts
          .map(
            (e) => Icon(
              e,
              color: starColor,
              size: starSize,
            ),
          )
          .toList(),
    );
  }
}
