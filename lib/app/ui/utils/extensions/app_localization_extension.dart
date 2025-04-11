import 'package:flutter/cupertino.dart';

import '../../../../../l10n/app_localizations.dart';

extension AppLocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
