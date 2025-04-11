import 'package:flutter/material.dart';

class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.loraRegularHeadline,
    required this.loraRegularTitle,
    required this.openRegularHeadline,
    required this.openRegularTitleSemiBold,
    required this.openRegularTitle,
    required this.openRegularText,
    required this.openRegularItalic,
  });

  final TextStyle loraRegularHeadline;
  final TextStyle loraRegularTitle;
  final TextStyle openRegularHeadline;
  final TextStyle openRegularTitleSemiBold;
  final TextStyle openRegularTitle;
  final TextStyle openRegularText;
  final TextStyle openRegularItalic;

  @override
  AppTypography copyWith({
    TextStyle? loraRegularHeadline,
    TextStyle? loraRegularTitle,
    TextStyle? openRegularHeadline,
    TextStyle? openRegularTitleSemiBold,
    TextStyle? openRegularTitle,
    TextStyle? openRegularText,
    TextStyle? openRegularItalic,
  }) {
    return AppTypography(
      loraRegularHeadline: loraRegularHeadline ?? this.loraRegularHeadline,
      loraRegularTitle: loraRegularTitle ?? this.loraRegularTitle,
      openRegularHeadline: openRegularHeadline ?? this.openRegularHeadline,
      openRegularTitleSemiBold: openRegularTitleSemiBold ?? this.openRegularTitleSemiBold,
      openRegularTitle: openRegularTitle ?? this.openRegularTitle,
      openRegularText: openRegularText ?? this.openRegularText,
      openRegularItalic: openRegularItalic ?? this.openRegularItalic,
    );
  }

  @override
  AppTypography lerp(covariant ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }

    return AppTypography(
      loraRegularHeadline: TextStyle.lerp(loraRegularHeadline, other.loraRegularHeadline, t)!,
      loraRegularTitle: TextStyle.lerp(loraRegularTitle, other.loraRegularTitle, t)!,
      openRegularHeadline: TextStyle.lerp(openRegularHeadline, other.openRegularHeadline, t)!,
      openRegularTitleSemiBold:
          TextStyle.lerp(openRegularTitleSemiBold, other.openRegularTitleSemiBold, t)!,
      openRegularTitle: TextStyle.lerp(openRegularTitle, other.openRegularTitle, t)!,
      openRegularText: TextStyle.lerp(openRegularText, other.openRegularText, t)!,
      openRegularItalic: TextStyle.lerp(openRegularItalic, other.openRegularItalic, t)!,
    );
  }
}
