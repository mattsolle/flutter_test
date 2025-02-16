import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

import '../router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = I18nProvider.of(context);
    return MaterialApp(
      title: 'Restaurant Tour',
      supportedLocales: i18n.supportedLocales,
      localizationsDelegates: i18n.localizationsDelegates,
      builder: (context, child) => const AppRouter(),
    );
  }
}
