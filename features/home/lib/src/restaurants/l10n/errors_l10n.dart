import 'package:i18n/i18n.dart';

class ErrorsL10n extends I18NextL10n {
  ErrorsL10n.of(super.context)
      : super(
          namespace: 'errors',
        );

  String get common => localize('common');
  String get noItems => localize('noItems');
  String get newPage => localize('newPage');
  String get yelp => localize('yelp');
}
