import 'dart:ui';

/// Defines a simple set of colors used in the application.
///
/// This class abstracts some UI-related colors that would typically be
/// retrieved from [ColorScheme]. In a real-world application, the best practice
/// is to use [Theme.of(context).colorScheme] to ensure consistency with the
/// Material Design guidelines.
///
/// However, for this coding challenge, this class is introduced to simplify
/// color management without relying on a full-fledged [ThemeData] structure.
class AppColors {
  const AppColors({
    required this.indicatorColor,
    required this.labelColor,
    required this.unselectedLabelColor,
  });

  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
}
