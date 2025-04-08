import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import '../mock_cached_network_image_widget.dart';

class TestRestaurantReviewItemWidget extends StatelessWidget {
  final Review review;

  const TestRestaurantReviewItemWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              review.rating?.round() ?? 0,
              (_) => const Icon(Icons.star, size: 16),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            review.text ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipOval(
                child: MockCachedNetworkImageWidget(
                  imgUrl: review.user?.imageUrl ?? "",
                  imgWidth: 40,
                  imgHeight: 40,
                  boxFit: BoxFit.cover,
                  errorWidget: const Icon(Icons.person),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  review.user?.name ?? AppStrings.anonymous,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class TestRestaurantReviewWidget extends StatelessWidget {
  final List<Review> reviews;

  const TestRestaurantReviewWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Text(
        AppStrings.noReviewsAvailable,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${reviews.length} ${AppStrings.reviews}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Column(
          children: reviews
              .map((review) => TestRestaurantReviewItemWidget(review: review))
              .toList(),
        ),
      ],
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RestaurantReviewWidget Golden and Widget Tests', () {
    testWidgets('Renders correctly with reviews and matches golden file',
        (tester) async {
      final reviews = List.generate(
        2,
        (index) => Review(
          rating: 5 - index,
          text: 'Review text for user $index',
          user: User(
            name: 'User $index',
            imageUrl: '',
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              child: TestRestaurantReviewWidget(reviews: reviews),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.textContaining(AppStrings.reviews), findsOneWidget);
      expect(find.text('Review text for user 0'), findsOneWidget);
      expect(find.text('Review text for user 1'), findsOneWidget);

      await expectLater(
        find.byType(TestRestaurantReviewWidget),
        matchesGoldenFile('goldens/restaurant_review_widget.png'),
      );
    });

    testWidgets('Renders correctly without reviews and matches golden file',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              child: TestRestaurantReviewWidget(reviews: []),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(AppStrings.noReviewsAvailable), findsOneWidget);

      await expectLater(
        find.byType(TestRestaurantReviewWidget),
        matchesGoldenFile('goldens/restaurant_review_widget_no_reviews.png'),
      );
    });
  });
}
