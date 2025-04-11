import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_tour/app/ui/design_system/atoms/stars_rating_widget.dart';

import '../../../test_widget.dart';

void main() {
  group('Widget Test - StarsRatingWidget', () {
    testWidgets(
        'Given the StarsRatingWidget component, \n'
        'When the rating is a full number, \n'
        'Then it should display that many full stars and the rest as empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          builder: (context) => const StarsRatingWidget(
            rating: 3,
            totalStars: 5,
            starColor: Colors.amber,
            starSize: 24,
          ),
        ),
      );

      final icons = tester.widgetList<Icon>(find.byType(Icon)).toList();

      expect(icons.where((icon) => icon.icon == Icons.star).length, 3);
      expect(icons.where((icon) => icon.icon == Icons.star_border).length, 2);
      expect(icons.where((icon) => icon.icon == Icons.star_half).length, 0);
    });

    testWidgets(
        'Given the StarsRatingWidget component, \n'
        'When the rating includes a half star, \n'
        'Then it should display full stars, one half star, and the rest as empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          builder: (context) => const StarsRatingWidget(
            rating: 3.6,
            totalStars: 5,
            starColor: Colors.amber,
            starSize: 20,
          ),
        ),
      );

      final icons = tester.widgetList<Icon>(find.byType(Icon)).toList();

      expect(icons.where((icon) => icon.icon == Icons.star).length, 3);
      expect(icons.where((icon) => icon.icon == Icons.star_half).length, 1);
      expect(icons.where((icon) => icon.icon == Icons.star_border).length, 1);
    });

    testWidgets(
        'Given the StarsRatingWidget component, \n'
        'When the rating is zero, \n'
        'Then it should display only empty stars', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          builder: (context) => const StarsRatingWidget(
            rating: 0,
            totalStars: 5,
            starColor: Colors.grey,
          ),
        ),
      );

      final icons = tester.widgetList<Icon>(find.byType(Icon)).toList();

      expect(icons.where((icon) => icon.icon == Icons.star).length, 0);
      expect(icons.where((icon) => icon.icon == Icons.star_half).length, 0);
      expect(icons.where((icon) => icon.icon == Icons.star_border).length, 5);
    });
  });
}
