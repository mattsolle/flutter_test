import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18next/i18next.dart';
import 'package:provider/provider.dart';

import 'single_file_asset_bundle_data_source.dart';

const List<Locale> kSupportedLocales = <Locale>[
  Locale('pt', 'BR'),
  Locale('en', 'US'),
];

class I18n extends ChangeNotifier {
  I18n({
    Locale? locale,
    required List<Locale> supportedLocales,
    required List<LocalizationsDelegate> localizationsDelegates,
  })  : _locale = locale ?? supportedLocales.first,
        supportedLocales = List.unmodifiable(supportedLocales),
        localizationsDelegates = List.unmodifiable(localizationsDelegates) {
    _log('Initializing locale with $_locale');
  }

  final Locale _locale;
  final List<Locale> supportedLocales;
  final List<LocalizationsDelegate> localizationsDelegates;

  Locale get locale => _locale;

  void _log(String message, [Object? error, StackTrace? stackTrace]) {
    log(message, error: error, stackTrace: stackTrace, name: 'I18n');
  }
}

class I18nProvider extends ChangeNotifierProvider<I18n> {
  I18nProvider({
    super.key,
    Locale? locale,
    List<Locale> supportedLocales = kSupportedLocales,
    required LocalizationDataSource localizationDataSource,
    I18NextOptions? i18nextOptions,
    super.lazy,
    super.builder,
    super.child,
  }) : super(
          create: (context) => I18n(
            locale: locale,
            supportedLocales: supportedLocales,
            localizationsDelegates: [
              ...GlobalMaterialLocalizations.delegates,
              I18NextLocalizationDelegate(
                locales: supportedLocales,
                dataSource: localizationDataSource,
                options: i18nextOptions,
              ),
            ],
          ),
        );

  I18nProvider.fromAssetBundle({
    Key? key,
    List<Locale> supportedLocales = kSupportedLocales,
    Locale? locale,
    String assetPath = 'packages/i18n/lib/l10n/<locale_name>.json',
    I18NextOptions? i18nextOptions,
    bool? lazy,
    TransitionBuilder? builder,
    Widget? child,
  }) : this(
          key: key,
          supportedLocales: supportedLocales,
          locale: locale,
          localizationDataSource: SingleAssetBundleLocalizationDataSource(
            assetPath: assetPath,
          ),
          i18nextOptions: i18nextOptions,
          lazy: lazy,
          builder: builder,
          child: child,
        );

  static I18n of(BuildContext context, {bool listen = true}) =>
      Provider.of<I18n>(context, listen: listen);
}
