import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:restaurant_tour/core/di/service_locator.dart';
import 'package:restaurant_tour/core/network/api_client.dart';
import 'package:restaurant_tour/core/observer/bloc_observer.dart';
import 'package:restaurant_tour/core/routes/app_router.dart';
import 'package:restaurant_tour/core/utils/app_logger.dart';
import 'package:restaurant_tour/features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_tour/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_tour/features/restaurant/domain/use_cases/fetch_restaurants.dart';
import 'package:restaurant_tour/features/restaurant/presentation/blocs/restaurant/restaurant_bloc.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/favourite_restaurants/favourite_restaurants_cubit.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/tab_navigation/tab_navigation_cubit.dart';

import '../../../mocks.dart';

void main() {
  final getIt = GetIt.instance;

  setUp(() async {
    await getIt.reset();
    HydratedBloc.storage = MockStorage();
    await setupLocator();
  });

  group('Service Locator Tests', () {
    test('should register AppLogger', () {
      expect(getIt<AppLogger>(), isA<AppLogger>());
    });

    test('should register ApiClient', () {
      expect(getIt<ApiClient>(), isA<ApiClient>());
    });

    test('should register http.Client', () {
      expect(getIt<http.Client>(), isA<http.Client>());
    });

    test('should register AppBlocObserver', () {
      expect(getIt<AppBlocObserver>(), isA<AppBlocObserver>());
    });

    test('should register AppRouter', () {
      expect(getIt<AppRouter>(), isA<AppRouter>());
    });

    test('should register GoRouter', () {
      expect(getIt<GoRouter>(), isA<GoRouter>());
    });

    test('should register RestaurantRepository', () {
      expect(getIt<RestaurantRepository>(), isA<RestaurantRepositoryImpl>());
    });

    test('should register FetchRestaurants use case', () {
      expect(getIt<FetchRestaurants>(), isA<FetchRestaurants>());
    });

    test('should register RestaurantBloc', () {
      expect(getIt<RestaurantBloc>(), isA<RestaurantBloc>());
    });

    test('should register FavoriteRestaurantsCubit', () {
      expect(
        getIt<FavoriteRestaurantsCubit>(),
        isA<FavoriteRestaurantsCubit>(),
      );
    });

    test('should register TabNavigationCubit', () {
      expect(getIt<TabNavigationCubit>(), isA<TabNavigationCubit>());
    });
  });
}
