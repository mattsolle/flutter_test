import 'package:flutter/material.dart';
import 'package:restaurant_tour/app/ui/features/app/app_router.dart';
import 'package:restaurant_tour/app/ui/style/theme_extensions/app_colors.dart';
import 'package:restaurant_tour/app/ui/style/typography.dart';
import 'package:restaurant_tour/l10n/app_localizations.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({
    super.key,
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late final AppRouter appRouter;

  late final ThemeData theme = ThemeData(
    extensions: const [
      AppTextStyles.defaultTypography,
      AppColors(
        ratingStars: Colors.amber,
        openStatusColor: Colors.green,
        closedStatusColor: Colors.red,
      ),
    ],
  );

  late final ThemeData darkTheme = theme.copyWith(
    colorScheme: theme.colorScheme.copyWith(
      brightness: Brightness.dark,
    ),
  );

  late final Locale locale = const Locale('en', 'US');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Tour',
      theme: theme,
      darkTheme: darkTheme,
      locale: locale,
      themeMode: ThemeMode.light,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) {
        return widget.builder(context);
      },
    );
  }
}
