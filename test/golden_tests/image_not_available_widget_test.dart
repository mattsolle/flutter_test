import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_tour/core/constants/app_icons.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/image_not_available_widget.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';

void main() {
  group('ImageNotAvailableWidget Tests', () {
    testWidgets(
        'Renders correctly with given dimensions and matches golden file',
        (WidgetTester tester) async {
      const imageWidth = 120.0;
      const imageHeight = 120.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ImageNotAvailableWidget(
                imageWidth: imageWidth,
                imageHeight: imageHeight,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ImageNotAvailableWidget), findsOneWidget);
      expect(find.text(AppStrings.imageNotAvailable), findsOneWidget);
      expect(find.byIcon(AppIcons.imageNotAvailable), findsOneWidget);

      await expectLater(
        find.byType(ImageNotAvailableWidget),
        matchesGoldenFile('goldens/image_not_available_widget.png'),
      );
    });
  });
}
