import 'package:i18n/i18n.dart';

class MainL10n extends I18NextL10n {
  MainL10n.of(super.context)
      : super(
          namespace: 'main',
        );

  String get title => localize('title');
}
