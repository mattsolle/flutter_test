import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../typography.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;
  final bool isFavorite;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              //Restaurant Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  restaurant.photos?.isNotEmpty == true
                      ? restaurant.photos![0]
                      : '',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Icon(Icons.restaurant, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              //Restaurant Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            restaurant.name ?? 'Unnamed Restaurant',
                            style: AppTextStyles.loraRegularHeadline.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isFavorite)
                          const Icon(Icons.favorite, color: Colors.red, size: 20),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Price and Categories
                    Row(
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
                    const SizedBox(height: 4),
                    // Rating stars and Open/Closed status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rating stars
                        Row(
                          children: List.generate(restaurant.rating?.round() ?? 0, (index) {                            
                            return Icon(
                              Icons.star,                                  
                              size: 16,
                              color: Colors.amber[700],
                            );
                          }),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}