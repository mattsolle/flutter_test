import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_colors.dart';

/// The main theme used by the app.
/// This is the root theme for most or all of app design system's
/// foundational values.
///
/// It should be noted that if you want to access material's values, then use
/// [Theme.of].
class AppTheme extends Provider<AppThemeData> {
  AppTheme({
    super.key,
    required AppThemeData data,
    super.child,
  }) : super.value(value: data);

  static AppThemeData of(BuildContext context, {bool listen = true}) {
    try {
      return Provider.of<AppThemeData>(context, listen: listen);
    } on ProviderNotFoundException {
      return _fallback(context);
    }
  }

  /// This fallback is only for conditions where the theme wasn't or can't be
  /// inserted, like tests.
  ///
  /// A theme value should always have been provided in normal conditions.
  static AppThemeData _fallback(BuildContext context) =>
      AppThemeData.light(context);
}

final class AppThemeData {
  AppThemeData._({
    required this.theme,
    required this.colors,
  });

  //TODO: Set Light Theme
  factory AppThemeData.light(BuildContext context) {
    final theme = AppThemeData._getTheme(
      context,
      brightness: Brightness.light,
    );
    return AppThemeData._(
      theme: theme,
      colors: const AppColors(
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
      ),
    );
  }

  //TODO: Set Dark Theme
  factory AppThemeData.dark(BuildContext context) {
    final theme = AppThemeData._getTheme(
      context,
      brightness: Brightness.dark,
    );
    return AppThemeData._(
      theme: theme,
      colors: const AppColors(
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
      ),
    );
  }

  final ThemeData theme;
  final AppColors colors;

  /// This method is responsible for constructing the foundational `ThemeData`
  /// used throughout the application. All global component styles, should be
  /// defined here.
  static ThemeData _getTheme(
    BuildContext context, {
    required Brightness brightness,
    ColorScheme? colorScheme,
  }) {
    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
    );
  }
}
