import 'package:flutter/material.dart';
import 'package:restaurant_tour/core/constants/app_colors.dart';
import 'package:restaurant_tour/core/theme/typography.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.textPrimary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.textPrimary,
      onPrimary: Colors.white,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.loraRegularHeadline,
      titleMedium: AppTextStyles.openRegularTitleSemiBold,
      bodyLarge: AppTextStyles.loraRegularTitle,
      bodyMedium: AppTextStyles.openRegularText,
      bodySmall: AppTextStyles.openRegularItalic,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 1,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: AppTextStyles.loraRegularHeadline,
      centerTitle: true,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.textPrimary,
      unselectedLabelColor: AppColors.textPrimary,
      labelStyle: AppTextStyles.openRegularTitleSemiBold,
      unselectedLabelStyle: AppTextStyles.openRegularTitleSemiBold,
      indicatorSize: TabBarIndicatorSize.label,
    ),
    listTileTheme: const ListTileThemeData(
      textColor: AppColors.textPrimary,
      iconColor: AppColors.textPrimary,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.starRating,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.textPrimary,
        foregroundColor: AppColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: AppTextStyles.openRegularTitleSemiBold,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      indent: 0.0,
      endIndent: 0.0,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: AppColors.textPrimary,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.loraRegularHeadline,
      titleMedium: AppTextStyles.openRegularTitleSemiBold,
      bodyLarge: AppTextStyles.loraRegularTitle,
      bodyMedium: AppTextStyles.openRegularText,
      bodySmall: AppTextStyles.openRegularItalic,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 1,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: AppTextStyles.loraRegularHeadline,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.textPrimary,
      unselectedLabelColor: AppColors.textPrimary,
      labelStyle: AppTextStyles.openRegularTitleSemiBold,
      unselectedLabelStyle: AppTextStyles.openRegularTitleSemiBold,
      indicatorSize: TabBarIndicatorSize.label,
    ),
    listTileTheme: const ListTileThemeData(
      textColor: AppColors.textPrimary,
      iconColor: AppColors.textPrimary,
    ),
  );
}
