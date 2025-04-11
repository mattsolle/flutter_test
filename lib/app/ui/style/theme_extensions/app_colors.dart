import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.ratingStars,
    required this.openStatusColor,
    required this.closedStatusColor,
  });

  final Color ratingStars;
  final Color openStatusColor;
  final Color closedStatusColor;

  @override
  AppColors copyWith({
    Color? ratingStars,
    Color? openStatusColor,
    Color? closedStatusColor,
  }) {
    return AppColors(
      ratingStars: ratingStars ?? this.ratingStars,
      openStatusColor: openStatusColor ?? this.openStatusColor,
      closedStatusColor: closedStatusColor ?? this.closedStatusColor,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      ratingStars: Color.lerp(ratingStars, other.ratingStars, t)!,
      openStatusColor: Color.lerp(openStatusColor, other.openStatusColor, t)!,
      closedStatusColor:
          Color.lerp(closedStatusColor, other.closedStatusColor, t)!,
    );
  }
}
