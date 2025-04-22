// test/widget_tests/restaurant_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_tour/components/restaurant_card.dart';
import 'package:restaurant_tour/models/restaurant.dart';

void main() {
  testWidgets('RestaurantCard displays restaurant information correctly', (WidgetTester tester) async {
    // Create a sample restaurant
    final restaurant = Restaurant(
      id: '1',
      name: 'Test Restaurant',
      rating: 4,
      price: '\$\$',
      photos: ['https://example.com/photo.jpg'],
      categories: [
        Category(title: 'Italian', alias: 'italian'),
        Category(title: 'Pizza', alias: 'pizza'),
      ],
      hours: [
        Hours(isOpenNow: true),
      ],
      location: Location(
        formattedAddress: '123 Test St, Test City, TS 12345',
      ),
    );

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RestaurantCard(
            restaurant: restaurant,
            onTap: () {},
            isFavorite: true,
          ),
        ),
      ),
    );

    // Verify restaurant name
    expect(find.text('Test Restaurant'), findsOneWidget);

    // Verify price
    expect(find.text('\$\$'), findsOneWidget);

    // Verify categories
    expect(find.text('Italian • Pizza'), findsOneWidget);

    // Verify open status
    expect(find.text('Open Now'), findsOneWidget);

    // Verify favorite icon
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Verify rating stars
    expect(find.byIcon(Icons.star), findsNWidgets(4)); // For rating 4
  });

  testWidgets('RestaurantCard handles null values gracefully', (WidgetTester tester) async {
    final restaurant = Restaurant(
      id: '1',
      name: null,
      rating: null,
      price: null,
      photos: null,
      categories: null,
      hours: null,
      location: null,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RestaurantCard(
            restaurant: restaurant,
            onTap: () {},
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Unnamed Restaurant'), findsOneWidget);
    expect(find.byIcon(Icons.restaurant), findsOneWidget);
  });
}