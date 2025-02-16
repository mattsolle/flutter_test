import 'package:i18n/i18n.dart';

class HomeL10n extends I18NextL10n {
  HomeL10n.of(super.context)
      : super(
          namespace: 'home',
        );

  String get title => localize('title');
}
