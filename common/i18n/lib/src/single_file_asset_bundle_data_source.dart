import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:i18next/i18next.dart';

/// Retrieves a single asset that contains all the localizations for a single
/// locale.
class SingleAssetBundleLocalizationDataSource
    implements LocalizationDataSource {
  SingleAssetBundleLocalizationDataSource({
    required this.assetPath,
    AssetBundle? bundle,
    this.cache = true,
  })  : bundle = bundle ?? rootBundle,
        super();

  /// The asset path that is defined on the pubspec.
  ///
  /// This string needs one point of substitution for [Locale]
  /// 'assets/<locale_name>.json' will be interpolated as
  /// 'assets/pt-BR.json'.
  final String assetPath;

  /// The [AssetBundle] where it retrieves the assets from.
  ///
  /// Defaults no [rootBundle].
  final AssetBundle bundle;

  final bool cache;

  /// The end result is a [Map] that contains all the namespaces.
  @override
  Future<Map<String, dynamic>> load(Locale locale) async {
    final assetKey =
        assetPath.replaceFirst('<locale_name>', locale.toLanguageTag());
    final assetContents = await bundle
        .loadString(assetKey, cache: cache)
        .then<Map<String, dynamic>>((string) => json.decode(string));
    return assetContents;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetBundleLocalizationDataSource &&
          runtimeType == other.runtimeType &&
          cache == other.cache &&
          bundle == other.bundle;

  @override
  int get hashCode => Object.hash(
        bundle,
        cache,
      );
}
