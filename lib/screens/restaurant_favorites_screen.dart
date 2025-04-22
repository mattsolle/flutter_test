import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../typography.dart';
import '../providers/favorites_provider.dart';
import '../components/restaurant_card.dart';
import 'restaurant_details_screen.dart';

class RestaurantFavoritesScreen extends ConsumerWidget {
  const RestaurantFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restaurants', style: AppTextStyles.loraRegularHeadline),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                'No favorite restaurants yet',
                style: AppTextStyles.openRegularText,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final restaurant = favorites[index];
                return RestaurantCard(
                  restaurant: restaurant,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailsScreen(
                          restaurantId: restaurant.id!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
} 