import 'package:i18n/i18n.dart';

class RestaurantL10n extends I18NextL10n {
  RestaurantL10n.of(super.context)
      : super(
          namespace: 'home',
          keyPrefix: 'restaurant',
        );

  String get opened => localize('opened');
  String get closed => localize('closed');
}
