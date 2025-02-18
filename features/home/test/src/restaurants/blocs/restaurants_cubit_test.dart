import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/src/restaurants/blocs/restaurants_cubit.dart';
import 'package:home/src/restaurants/blocs/restaurants_state.dart';
import 'package:home/src/restaurants/data/models/exceptions.dart';
import 'package:home/src/restaurants/data/models/restaurant.dart';
import 'package:home/src/restaurants/data/repositories/restaurants_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRestaurantsRepository extends Mock implements RestaurantsRepository {}

void main() {
  late MockRestaurantsRepository mockRepository;

  const mockRestaurants = <Restaurant>[
    Restaurant(id: '1', name: 'Restaurant 1'),
    Restaurant(id: '2', name: 'Restaurant 2'),
  ];
  const totalRestaurants = 10;

  setUp(() {
    mockRepository = MockRestaurantsRepository();
  });

  blocTest<RestaurantsCubit, RestaurantsState>(
    'emits [loading, success] when fetchRestaurants succeeds',
    build: () {
      when(() => mockRepository.fetchRestaurants(offset: 0))
          .thenAnswer((_) async => (mockRestaurants, totalRestaurants));

      return RestaurantsCubit(repository: mockRepository);
    },
    expect: () {
      return [
        isA<RestaurantsState>().having(
          (state) => state.status,
          'status',
          RestaurantsStatus.success,
        ),
      ];
    },
    verify: (_) {
      verify(() => mockRepository.fetchRestaurants(offset: 0)).called(1);
    },
  );

  blocTest<RestaurantsCubit, RestaurantsState>(
    'emits [loading, yelpLimit] when YelpRateLimitException is thrown',
    build: () {
      when(() => mockRepository.fetchRestaurants(offset: 0))
          .thenThrow(YelpRateLimitException());

      return RestaurantsCubit(repository: mockRepository);
    },
    expect: () => [
      isA<RestaurantsState>().having(
        (state) => state.status,
        'status',
        RestaurantsStatus.yelpLimit,
      ),
    ],
  );

  blocTest<RestaurantsCubit, RestaurantsState>(
    'emits [loading, error] when fetchRestaurants fails',
    build: () {
      when(() => mockRepository.fetchRestaurants(offset: 0))
          .thenThrow(Exception('Network error'));

      return RestaurantsCubit(repository: mockRepository);
    },
    expect: () => [
      isA<RestaurantsState>().having(
        (state) => state.status,
        'status',
        RestaurantsStatus.error,
      ),
    ],
  );

  blocTest<RestaurantsCubit, RestaurantsState>(
    'closes the cubit and disposes PagingController',
    build: () => RestaurantsCubit(repository: mockRepository),
    act: (cubit) async {
      await cubit.close();
    },
    errors: () => [isA<StateError>()],
  );
}
