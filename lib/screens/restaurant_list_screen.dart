import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../typography.dart';
import '../providers/restaurant_provider.dart';
import '../providers/favorites_provider.dart';
import '../models/restaurant.dart';
import 'restaurant_details_screen.dart';
import '../components/restaurant_card.dart';

class RestaurantListScreen extends ConsumerStatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  ConsumerState<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends ConsumerState<RestaurantListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantsAsync = ref.watch(restaurantsProvider);
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('RestauranTour', 
          style: AppTextStyles.loraRegularHeadline.copyWith(color: Colors.black)
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.black, 
              dividerColor: Colors.transparent,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 80),
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              tabs: const [
                Tab(text: 'All Restaurants'),
                Tab(text: 'My Favorites'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _buildRestaurantList(restaurantsAsync, favorites),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _buildFavoritesList(favorites),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantList(AsyncValue<RestaurantQueryResult?> restaurantsAsync, List<Restaurant> favorites) {
    return restaurantsAsync.when(
      loading: () => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.black,
            ),
            SizedBox(height: 16),           
          ],
        ),
      ),
      error: (error, stack) => Center(
        child: Text('Error: $error', 
          style: AppTextStyles.openRegularText.copyWith(color: Colors.black)
        ),
      ),
      data: (result) {
        if (result == null || result.restaurants == null) {
          return const Center(
            child: Text('No restaurants found'),
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -2),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 160),
            itemCount: result.restaurants!.length,
            itemBuilder: (context, index) {
              final sortedRestaurants = List<Restaurant>.from(result.restaurants!)
                ..sort((a, b) {
                  final aIsOpen = a.hours?[0].isOpenNow ?? false;
                  final bIsOpen = b.hours?[0].isOpenNow ?? false;
                  return bIsOpen.toString().compareTo(aIsOpen.toString());
                });
              
              final restaurant = sortedRestaurants[index];
              final isFavorite = favorites.any((r) => r.id == restaurant.id);
              
              return RestaurantCard(
                restaurant: restaurant,
                isFavorite: isFavorite,
                onTap: () {
                  if (restaurant.id != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailsScreen(
                          restaurantId: restaurant.id!,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFavoritesList(List<Restaurant> favorites) {
    if (favorites.isEmpty) {
      return Center(
        child: Text(
          'No favorite restaurants yet',
          style: AppTextStyles.openRegularText,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 160),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final sortedFavorites = List<Restaurant>.from(favorites)
            ..sort((a, b) {
              final aIsOpen = a.hours?[0].isOpenNow ?? false;
              final bIsOpen = b.hours?[0].isOpenNow ?? false;
              return bIsOpen.toString().compareTo(aIsOpen.toString());
            });
          
          final restaurant = sortedFavorites[index];
          return RestaurantCard(
            restaurant: restaurant,
            isFavorite: true,
            onTap: () {
              if (restaurant.id != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantDetailsScreen(
                      restaurantId: restaurant.id!,
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
} 