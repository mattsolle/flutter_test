import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_tour/app/ui/design_system/atoms/image_avatar_widget.dart';
import 'package:restaurant_tour/app/ui/utils/extensions/image_provider_extension.dart';

import '../../../test_widget.dart';

void main() {
  group('Widget Test - ImageAvatarWidget', () {
    testWidgets(
        'Given the ImageAvatarWidget component, \n'
        'When rendered with specific image, size, and shape, \n'
        'Then it should display the image with correct dimensions and shape',
        (WidgetTester tester) async {
      const double avatarSize = 80;
      final imageProvider = ''.toImageProvider.orDefaultImage;
      const shape = CircleBorder();

      await tester.pumpWidget(
        TestWidget(
          builder: (context) => ImageAvatarWidget(
            image: imageProvider,
            size: avatarSize,
            shape: shape,
          ),
        ),
      );

      final materialFinder = find.byType(Material);
      final inkFinder = find.byType(Ink);

      expect(materialFinder, findsOneWidget);
      expect(inkFinder, findsOneWidget);

      final Ink inkWidget = tester.widget(inkFinder);
      expect(inkWidget.height, avatarSize);
      expect(inkWidget.width, avatarSize);
    });
  });
}
