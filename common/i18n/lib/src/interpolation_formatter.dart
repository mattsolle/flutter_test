import 'dart:ui';

import 'package:i18next/i18next.dart';
import 'package:intl/intl.dart';

/// Gets all the default formatters for the i18next machine
Map<String, ValueFormatter> get formatters => {
      'uppercase': _toUpperCase,
      'lowercase': _toLowerCase,
      'sentence': _toSentenceCase,
    };

Object? interpolationFallback(
  Object? value,
  InterpolationFormat format,
  Locale locale,
  I18NextOptions options,
) {
  if (value is num) {
    return value.toString();
  }

  return value;
}

String? _toUpperCase(
  Object? value,
  InterpolationFormat format,
  Locale locale,
  I18NextOptions options,
) =>
    value?.toString().toUpperCase();

String? _toLowerCase(
  Object? value,
  InterpolationFormat format,
  Locale locale,
  I18NextOptions options,
) =>
    value?.toString().toLowerCase();

String? _toSentenceCase(
  Object? value,
  InterpolationFormat format,
  Locale locale,
  I18NextOptions options,
) =>
    toBeginningOfSentenceCase(value?.toString());
