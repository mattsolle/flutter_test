import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:path/path.dart' as path;

import '../i18next.dart';

class TestAssetBundleLocalizationsDataSource implements LocalizationDataSource {
  TestAssetBundleLocalizationsDataSource({
    this.assetPath = 'packages/i18n/lib/l10n/<locale_name>.json',
  });

  /// The asset path that is defined on the pubspec.
  ///
  /// This string needs one point of substitution for [Locale]
  /// 'assets/<locale_name>.json' will be interpolated as
  /// 'assets/pt-BR.json'.
  final String assetPath;

  /// Loads the associated 'json' [locale] file declared in UNIT_TEST_ASSETS
  /// directory.
  /// The assets themselves must have been previously declared in pubspec.yaml.
  ///
  /// The end result is a [Map] that contains all the namespaces which are
  /// the file names themselves (case sensitive).
  @override
  Future<Map<String, dynamic>> load(Locale locale) async {
    final assetsPath = Platform.environment['UNIT_TEST_ASSETS']!;
    final assetKeyName =
        assetPath.replaceFirst('<locale_name>', locale.toLanguageTag());
    final file = File(path.join(assetsPath, assetKeyName));
    return json.decode(file.readAsStringSync());
  }
}
