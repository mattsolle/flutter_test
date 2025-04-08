import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:restaurant_tour/core/network/api_client.dart';
import 'package:restaurant_tour/core/utils/app_logger.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import 'package:restaurant_tour/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_tour/features/restaurant/domain/use_cases/fetch_restaurants.dart';
import 'package:restaurant_tour/features/restaurant/presentation/blocs/restaurant/restaurant_bloc.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/favourite_restaurants/favourite_restaurants_cubit.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/tab_navigation/tab_navigation_cubit.dart';

// Mock for HttpClient
class MockHttpClient extends Mock implements http.Client {}

// Mock for AppLogger
class MockAppLogger extends Mock implements AppLogger {}

// Mock for ApiClient
class MockApiClient extends Mock implements ApiClient {}

// Mock for RestaurantRepository
class MockRestaurantRepository extends Mock implements RestaurantRepository {}

// Mock for FetchRestaurants use case
class MockFetchRestaurants extends Mock implements FetchRestaurants {}

// Mock for RestaurantBloc
class MockRestaurantBloc extends Mock implements RestaurantBloc {}

// Mock for FavoriteRestaurantsCubit
class MockFavoriteRestaurantsCubit extends Mock
    implements FavoriteRestaurantsCubit {}

//Mock for TabNavigationCubit
class MockTabNavigationCubit extends Mock implements TabNavigationCubit {}

// Mock Storage for HydratedBloc
class MockStorage extends Mock implements Storage {}

// Fake Uri to prevent Mocktail errors
class FakeUri extends Fake implements Uri {}

// Mock ImageProvider
class MockImageProvider extends Mock implements ImageProvider {}

class TestPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String> getTemporaryPath() async => '.';

  @override
  Future<String> getApplicationSupportPath() async => '.';
}

// Register fallback values for Mocktail to avoid type issues
void registerMockFallbackValues() {
  registerFallbackValue(FakeUri());
}

// mock restaurants for testing
List<Restaurant> createMockRestaurants(int count) {
  return List.generate(count, (index) {
    return Restaurant(
      id: 'id_$index',
      name: 'Restaurant $index',
      price: '\$\$',
      rating: 4.5,
      photos: const ['https://via.placeholder.com/150'],
      categories: [
        Category(alias: 'category_$index', title: 'Category $index'),
      ],
      hours: [Hours(isOpenNow: index % 2 == 0)],
      reviews: [
        Review(
          id: 'review_$index',
          text: 'Review for restaurant $index',
          rating: 5,
          user: User(id: 'user_$index', name: 'User $index', imageUrl: ''),
        ),
      ],
      location: Location(formattedAddress: '123 Test St, City $index'),
    );
  });
}
