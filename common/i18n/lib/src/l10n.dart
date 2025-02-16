import 'package:flutter/widgets.dart';
import 'package:i18next/i18next.dart';

import 'utils.dart';

typedef LocalizeFallback = String Function(String key);

/// A convenient localization base class for adding an access layer of
/// properties or methods, rather than relying only on String keys.
///
/// See also [CommonL10n] for the most common localizations.
/// And [I18NextL10n] for the base localization mechanism.
abstract class L10n {
  const L10n({this.arguments});

  /// Optional default arguments added for every [localize] and
  /// [localizeOptional] operations.
  final Map<String, dynamic>? arguments;

  String localize(
    String key, {
    int? count,
    String? context,
    Map<String, dynamic>? arguments,
    LocalizeFallback? orElse,
  });

  String? localizeOptional(
    String key, {
    int? count,
    String? context,
    Map<String, dynamic>? arguments,
  });
}

class I18NextL10n extends L10n {
  I18NextL10n(
    BuildContext context, {
    required this.namespace,
    this.keyPrefix,
    super.arguments,
  }) : // for this l10n to work, I18Next instance must exist at runtime
        _i18next = I18Next.of(context)!;

  final I18Next _i18next;
  final String? namespace;
  final String? keyPrefix;

  @override
  String localize(
    String key, {
    int? count,
    String? context,
    Map<String, dynamic>? arguments,
    LocalizeFallback? orElse,
  }) {
    return _i18next.t(
      _adjustKey(key),
      count: count,
      context: context,
      variables: mergeArguments(this.arguments, arguments),
      orElse: orElse,
    );
  }

  @override
  String? localizeOptional(
    String key, {
    int? count,
    String? context,
    Map<String, dynamic>? arguments,
  }) {
    return _i18next.tOrNull(
      _adjustKey(key),
      count: count,
      context: context,
      variables: mergeArguments(this.arguments, arguments),
    );
  }

  String _adjustKey(String key) {
    var newKey = key;
    if (keyPrefix != null) {
      final keySeparator = _i18next.options.keySeparator ?? '.';
      newKey = '$keyPrefix$keySeparator$newKey';
    }
    if (namespace != null) {
      final nsSeparator = _i18next.options.namespaceSeparator ?? ':';
      newKey = '$namespace$nsSeparator$newKey';
    }
    return newKey;
  }
}
