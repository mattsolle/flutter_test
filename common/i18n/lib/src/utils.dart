import 'dart:io';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:intl/locale.dart' as locale;

/// Based on the system's locale, determines the most appropriate [Locale]
/// from [supportedLocales].
/// Returns null if no appropriate locale was found.
Locale? determineLocale(List<Locale> supportedLocales) {
  final currentLocale = Platform.localeName;
  final parsed = tryParseLocale(currentLocale);
  return parsed != null ? findSupportedLocale(parsed, supportedLocales) : null;
}

/// Attempts to parse [identifier] into a [Locale].
/// Returns null if it fails or if it is mal-formed.
Locale? tryParseLocale(String identifier) {
  final parsed = locale.Locale.tryParse(identifier);
  return parsed != null
      ? Locale(parsed.languageCode, parsed.countryCode)
      : null;
}

/// Attempts to find a matching [Locale] in [supportedLocales].
/// Returns null if no appropriate locale was found.
///
/// The [supportedLocales] order matters when determining the fallback when
/// an exact match can't be found. (first is preferred)
Locale? findSupportedLocale(
  Locale locale,
  List<Locale> supportedLocales,
) {
  return supportedLocales.firstWhereOrNull((e) => e == locale) ??
      supportedLocales.firstWhereOrNull(
        (e) => e.languageCode == locale.languageCode,
      );
}

/// Merges two [Map]s such that:
/// (null, null) = null
/// (some(a), null) = some(a)
/// (null, some(b)) = some(b)
/// (some(a), some(b)) = some(a+b)
Map<String, dynamic>? mergeArguments(
  Map<String, dynamic>? baseArguments,
  Map<String, dynamic>? newArguments,
) {
  if (newArguments == null) return baseArguments;
  if (baseArguments == null) return newArguments;
  return {...baseArguments, ...newArguments};
}
