import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:i18n/i18next.dart';

Widget setupAppTest({required WidgetBuilder builder}) {
  return I18nProvider.fromAssetBundle(
    i18nextOptions: I18NextOptions(
      formats: formatters,
      missingInterpolationHandler: interpolationFallback,
    ),
    child: Builder(
      builder: (context) {
        final i18n = I18nProvider.of(context);
        return MaterialApp(
          title: 'Restaurant Tour Test',
          supportedLocales: i18n.supportedLocales,
          localizationsDelegates: i18n.localizationsDelegates,
          home: Builder(builder: builder),
        );
      },
    ),
  );
}
