import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/restaurant_address_widget.dart';

void main() {
  group('RestaurantAddressWidget Tests', () {
    testWidgets('Renders address when provided and matches golden file',
        (WidgetTester tester) async {
      final restaurant = Restaurant(
        location: Location(formattedAddress: '123 Flutter Street, Dart City'),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: RestaurantAddressWidget(restaurant: restaurant),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(RestaurantAddressWidget), findsOneWidget);
      expect(find.text(AppStrings.address), findsOneWidget);
      expect(find.text('123 Flutter Street, Dart City'), findsOneWidget);

      await expectLater(
        find.byType(RestaurantAddressWidget),
        matchesGoldenFile('goldens/restaurant_address_widget.png'),
      );
    });

    testWidgets('Renders no-address text when address is missing',
        (WidgetTester tester) async {
      const restaurant = Restaurant(location: null);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                child: RestaurantAddressWidget(restaurant: restaurant),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(RestaurantAddressWidget), findsOneWidget);
      expect(find.text(AppStrings.address), findsOneWidget);
      expect(find.text(AppStrings.noAddressAvailable), findsOneWidget);

      await expectLater(
        find.byType(RestaurantAddressWidget),
        matchesGoldenFile('goldens/restaurant_address_widget_no_address.png'),
      );
    });
  });
}
