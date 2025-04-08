import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/image_not_available_widget.dart';
import '../mock_cached_network_image_widget.dart';

void main() {
  group('MockCachedNetworkImageWidget Golden Test', () {
    testWidgets('Renders correctly and matches golden file', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: MockCachedNetworkImageWidget(
                imgUrl: 'https://example.com/user1.jpg',
                imgWidth: 100,
                imgHeight: 100,
                errorWidget: ImageNotAvailableWidget(
                  imageWidth: 100,
                  imageHeight: 100,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MockCachedNetworkImageWidget), findsOneWidget);
      expect(find.byIcon(Icons.image), findsOneWidget);

      await expectLater(
        find.byType(MockCachedNetworkImageWidget),
        matchesGoldenFile('goldens/mock_cached_network_image_widget.png'),
      );
    });
  });
}
