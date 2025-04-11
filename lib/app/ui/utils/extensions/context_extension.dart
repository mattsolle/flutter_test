import 'package:flutter/material.dart';

import '../../style/theme_extensions/app_colors.dart';
import '../../style/theme_extensions/app_typography.dart';

extension ContextExtension on BuildContext {
  Locale get locale => Localizations.localeOf(this);

  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  NavigatorState get navigator => Navigator.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppTypography get appTypography => Theme.of(this).extension<AppTypography>()!;

  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
