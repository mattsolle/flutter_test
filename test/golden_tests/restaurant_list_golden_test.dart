import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import '../mock_cached_network_image_widget.dart';
import '../mocks.dart';

class TestRestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;

  const TestRestaurantList({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 400,
          height: 600,
          child: ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      MockCachedNetworkImageWidget(
                        imgUrl: restaurant.heroImage,
                        imgWidth: 88,
                        imgHeight: 88,
                        heroTag: "restaurant_${restaurant.id}",
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name ?? "Restaurant Name",
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${restaurant.price ?? "\$\$"} ${restaurant.displayCategory}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: List.generate(
                                        restaurant.rating?.round() ?? 0,
                                        (_) => const Icon(Icons.star, size: 14),
                                      ),
                                    ),
                                    Text(restaurant.isOpen ? "Open" : "Closed"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RestaurantList Golden Test', () {
    testWidgets('Renders correctly and matches golden file', (tester) async {
      final restaurants = createMockRestaurants(3);

      await tester.pumpWidget(TestRestaurantList(restaurants: restaurants));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      await expectLater(
        find.byType(ListView),
        matchesGoldenFile('goldens/restaurant_list_widget.png'),
      );
    });
  });
}
