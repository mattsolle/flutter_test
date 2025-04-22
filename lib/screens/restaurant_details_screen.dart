import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../typography.dart';
import '../providers/restaurant_provider.dart';
import '../providers/favorites_provider.dart';

class RestaurantDetailsScreen extends ConsumerWidget {
  final String restaurantId;
  
  const RestaurantDetailsScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(restaurantProvider(restaurantId));
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        
        title: restaurantAsync.when(
          loading: () => Text('', style: AppTextStyles.loraRegularHeadline),
          error: (_, __) => Text('Restaurant Details', style: AppTextStyles.loraRegularHeadline),
          data: (result) => Text(
            result?.restaurants?.first.name ?? 'Restaurant Details',
            style: AppTextStyles.loraRegularHeadline,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          if (restaurantAsync.value != null && restaurantAsync.value!.restaurants != null && restaurantAsync.value!.restaurants!.isNotEmpty)
            IconButton(
              icon: Icon(
                favorites.any((r) => r.id == restaurantAsync.value!.restaurants!.first.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favorites.any((r) => r.id == restaurantAsync.value!.restaurants!.first.id)
                    ? Colors.red
                    : null,
              ),
              onPressed: () {
                if (restaurantAsync.value != null && 
                    restaurantAsync.value!.restaurants != null && 
                    restaurantAsync.value!.restaurants!.isNotEmpty) {
                  ref.read(favoritesProvider.notifier).toggleFavorite(
                    restaurantAsync.value!.restaurants!.first,
                  );
                }
              },
            ),
        ],
      ),
      body: restaurantAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
        error: (error, stack) => Center(
          child: Text('Error: $error', style: AppTextStyles.openRegularText),
        ),
        data: (result) {
          if (result == null || result.restaurants == null || result.restaurants!.isEmpty) {
            return const Center(
              child: Text('Restaurant not found'),
            );
          }

          final restaurant = result.restaurants!.first;
          
          return SingleChildScrollView(
            child: Column(              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant Image
                if (restaurant.photos != null && restaurant.photos!.isNotEmpty)
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      restaurant.photos![0],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(
                              Icons.restaurant,
                              color: Colors.grey,
                              size: 48,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 200,
                          color: Colors.grey[100],
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.restaurant,
                        color: Colors.grey,
                        size: 48,
                      ),
                    ),
                  ),
                // Price, Categories, and Open Status
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price and Categories
                      Expanded(
                        child: Row(
                          children: [
                            // Price
                            Text(
                              restaurant.price ?? '',
                              style: AppTextStyles.openRegularText.copyWith(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Categories
                            Expanded(
                              child: Text(
                                restaurant.categories?.map((c) => c.title).join(' • ') ?? '',
                                style: AppTextStyles.openRegularText.copyWith(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Open/Closed status
                      Row(
                        children: [
                          Text(
                            restaurant.hours?[0].isOpenNow == true
                                ? 'Open Now'
                                : 'Closed',
                            style: AppTextStyles.openRegularText.copyWith(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: restaurant.hours?[0].isOpenNow == true
                                  ? const Color(0xFF5CD313)
                                  : const Color(0xFFEA5E5E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(height: 1, color: Colors.black12),
                      const SizedBox(height: 24),
                      Text('Address', style: AppTextStyles.openRegularText.copyWith(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,                                
                              ),),
                      const SizedBox(height: 24),
                      Text(restaurant.location?.formattedAddress ?? 'No address available',
                          style: AppTextStyles.openRegularText.copyWith(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,   
                                height: 1.5,          
                              )),
                      const SizedBox(height: 16),
                      const Divider(height: 1, color: Colors.black12),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Overall Rating', style: AppTextStyles.openRegularText.copyWith(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,                                
                              ),),
                              const SizedBox(height: 8),
                              Row(
                                 crossAxisAlignment: CrossAxisAlignment.end, 
                                children: [
                                  Text(
                                    '${restaurant.rating ?? 0}',
                                    style: AppTextStyles.loraRegularTitle.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: const Offset(0, -8), 
                                    child: Icon(Icons.star, size: 12, color: const Color(0xFFFFB800))        
                                  ),
                                                          
                                ]
                              ),
                            ],
                          ),                         
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 1, color: Colors.black12),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                          const SizedBox(height: 8),
                          Text(
                            '${restaurant.reviews?.length ?? 0} Reviews',
                            style: AppTextStyles.openRegularText.copyWith(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Reviews List
                      if (restaurant.reviews != null && restaurant.reviews!.isNotEmpty)
                        ...restaurant.reviews!.map((review) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Rating stars
                            Row(
                              children: List.generate(review.rating ?? 0, (index) {
                                return Icon(
                                   Icons.star,
                                  size: 12,
                                  color: const Color(0xFFFFB800),
                                );
                              }),
                            ),
                            const SizedBox(height: 12),
                            // Review text
                            Text(
                              review.text ?? '',
                              style: AppTextStyles.openRegularText.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // User info row
                            Row(
                              children: [
                                // User image
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: review.user?.imageUrl != null
                                        ? DecorationImage(
                                            image: NetworkImage(review.user!.imageUrl!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                    color: Colors.grey[200],
                                  ),
                                  child: review.user?.imageUrl == null
                                      ? const Icon(
                                          Icons.person,
                                          size: 20,
                                          color: Colors.grey,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 8),
                                // User name
                                Text(
                                  review.user?.name ?? 'Anonymous',
                                  style: AppTextStyles.openRegularText.copyWith(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(height: 1, color: Colors.black12),
                            const SizedBox(height: 16),
                          ],
                        )).toList()
                      else
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'No reviews yet',
                            style: AppTextStyles.openRegularText.copyWith(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 160),
              ],               
            ),
          );
        },
      ),
    );
  }
} 