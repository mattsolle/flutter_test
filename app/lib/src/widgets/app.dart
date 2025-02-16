import 'dart:ui' as ui;

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

import '../router/app_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _useDarkTheme(ThemeMode? themeMode) {
    final mode = themeMode ?? ThemeMode.system;
    final platformBrightness = MediaQuery.platformBrightnessOf(context);

    return mode == ThemeMode.dark ||
        (mode == ThemeMode.system && platformBrightness == ui.Brightness.dark);
  }

  AppThemeData _resolveTheme(ThemeMode? themeMode) {
    final useDarkTheme = _useDarkTheme(themeMode);
    if (useDarkTheme) {
      return AppThemeData.dark(context);
    } else {
      return AppThemeData.light(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18nProvider.of(context);
    const themeMode = ThemeMode.light;
    final appThemeData = _resolveTheme(themeMode);
    return MaterialApp(
      title: 'Restaurant Tour',
      theme: appThemeData.theme,
      supportedLocales: i18n.supportedLocales,
      localizationsDelegates: i18n.localizationsDelegates,
      builder: (context, child) => const AppRouter(),
    );
  }
}
