// test/integration_tests/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_tour/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_tour/providers/restaurant_provider.dart';
import 'package:restaurant_tour/providers/favorites_provider.dart';
import 'package:restaurant_tour/models/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('App shows restaurant list and can navigate between tabs', (WidgetTester tester) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Create a ProviderContainer with all necessary overrides
    final container = ProviderContainer(
      overrides: [
        // Override SharedPreferences provider
        sharedPreferencesProvider.overrideWithValue(prefs),
        
        // Override restaurants provider to return mock data
        restaurantsProvider.overrideWith((ref) => 
          Future.value(RestaurantQueryResult(
            restaurants: [
              Restaurant(
                id: '1',
                name: 'Test Restaurant',
                price: '\$\$',
                rating: 4.5,
                categories: [Category(title: 'Test Category')],
                hours: [Hours(isOpenNow: true)],
              ),
            ],
          ))
        ),
      ],
    );

    // Build the app with provider overrides
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: RestaurantTour(),
        ),
      ),
    );

    // Wait for initial load
    await tester.pumpAndSettle();

    // Verify initial state
    expect(find.text('RestauranTour'), findsOneWidget);
    expect(find.text('All Restaurants'), findsOneWidget);
    expect(find.text('My Favorites'), findsOneWidget);

    // Test tab navigation
    await tester.tap(find.text('My Favorites'));
    await tester.pumpAndSettle();
    
    // Verify we're on favorites tab
    expect(find.text('No favorite restaurants yet'), findsOneWidget);

    // Go back to all restaurants
    await tester.tap(find.text('All Restaurants'));
    await tester.pumpAndSettle();

    // Clean up
    container.dispose();
  });
}