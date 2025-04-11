import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_tour/app/ui/design_system/atoms/restaurant_price_and_categories_widget.dart';

import '../../../test_widget.dart';

void main() {
  group('Widget Test - RestaurantPriceAndTagsWidget', () {
    testWidgets(
        'Given the RestaurantPriceAndTagsWidget component, \n'
        'When rendered with a price and a list of tags, \n'
        'Then it should display the price followed by all tags with proper spacing',
        (WidgetTester tester) async {
      const String price = r'$20';
      final List<String> tags = ['Sushi', 'Japanese', 'Seafood'];

      await tester.pumpWidget(
        TestWidget(
          builder: (context) => RestaurantPriceAndTagsWidget(
            price: price,
            tags: tags,
          ),
        ),
      );

      expect(find.text(price), findsOneWidget);
      expect(find.text('Sushi'), findsOneWidget);
      expect(find.text('Japanese'), findsOneWidget);
      expect(find.text('Seafood'), findsOneWidget);
    });

    testWidgets(
        'Given the RestaurantPriceAndTagsWidget component, \n'
        'When rendered with a price and an empty list of tags, \n'
        'Then it should display only the price without extra spacing or tag rows',
        (WidgetTester tester) async {
      const String price = r'$10';

      await tester.pumpWidget(
        TestWidget(
          builder: (context) => const RestaurantPriceAndTagsWidget(
            price: price,
            tags: [],
          ),
        ),
      );

      expect(find.text(price), findsOneWidget);
      expect(find.byType(Row), findsNothing);
    });
  });
}
