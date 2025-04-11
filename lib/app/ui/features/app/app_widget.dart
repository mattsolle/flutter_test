import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../setup.dart';
import '../../style/theme_extensions/app_colors.dart';
import '../../style/typography.dart';
import 'app_router.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
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
  void initState() {
    super.initState();
    final i = setup();
    appRouter = AppRouter(i);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Restaurant Tour',
      theme: theme,
      darkTheme: darkTheme,
      locale: locale,
      themeMode: ThemeMode.light,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: appRouter.router,
    );
  }
}
