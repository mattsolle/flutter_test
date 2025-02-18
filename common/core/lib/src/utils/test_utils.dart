import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:i18n/i18next.dart';

class SetupAppTester extends StatelessWidget {
  const SetupAppTester({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return I18nProvider(
      i18nextOptions: I18NextOptions(
        formats: formatters,
        missingInterpolationHandler: interpolationFallback,
      ),
      localizationDataSource: TestAssetBundleLocalizationsDataSource(),
      child: Builder(
        builder: (context) {
          final i18n = I18nProvider.of(context);
          return MaterialApp(
            title: 'Restaurant Tour Test',
            supportedLocales: i18n.supportedLocales,
            localizationsDelegates: i18n.localizationsDelegates,
            home: Material(child: child),
          );
        },
      ),
    );
  }
}
