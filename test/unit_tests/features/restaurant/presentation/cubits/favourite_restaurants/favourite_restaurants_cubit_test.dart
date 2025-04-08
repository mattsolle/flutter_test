import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/favourite_restaurants/favourite_restaurants_cubit.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import '../../../../../../mocks.dart';

void main() {
  late FavoriteRestaurantsCubit favoriteRestaurantsCubit;
  late MockStorage storage;

  setUp(() async {
    storage = MockStorage();
    when(() => storage.write(any(), any()))
        .thenAnswer((_) async => Future.value());
    when(() => storage.read(any())).thenReturn(null);
    when(() => storage.delete(any())).thenAnswer((_) async => Future.value());
    when(() => storage.clear()).thenAnswer((_) async => Future.value());

    HydratedBloc.storage = storage;
    favoriteRestaurantsCubit = FavoriteRestaurantsCubit();
  });

  tearDown(() {
    favoriteRestaurantsCubit.close();
  });

  const testRestaurant = Restaurant(id: "1", name: "Favorite Restaurant");

  group("FavoriteRestaurantsCubit Tests", () {
    test("Initial state should be FavoriteRestaurantsLoaded([])", () {
      expect(
        favoriteRestaurantsCubit.state,
        equals(const FavoriteRestaurantsLoaded([])),
      );
    });

    blocTest<FavoriteRestaurantsCubit, FavoriteRestaurantsState>(
      "emits FavoriteRestaurantsLoaded with a restaurant added when toggleFavoriteRestaurant is called",
      build: () => favoriteRestaurantsCubit,
      act: (cubit) => cubit.toggleFavoriteRestaurant(testRestaurant),
      expect: () => [
        const FavoriteRestaurantsLoaded([testRestaurant]),
      ],
    );

    blocTest<FavoriteRestaurantsCubit, FavoriteRestaurantsState>(
      "emits FavoriteRestaurantsLoaded with an empty list when the same restaurant is removed",
      build: () => favoriteRestaurantsCubit,
      act: (cubit) {
        cubit.toggleFavoriteRestaurant(testRestaurant);
        cubit.toggleFavoriteRestaurant(testRestaurant);
      },
      expect: () => [
        const FavoriteRestaurantsLoaded([testRestaurant]),
        const FavoriteRestaurantsLoaded([]),
      ],
    );

    test("isFavoriteRestaurant returns true when restaurant is in favorites",
        () {
      favoriteRestaurantsCubit.toggleFavoriteRestaurant(testRestaurant);
      expect(
        favoriteRestaurantsCubit.isFavoriteRestaurant(testRestaurant),
        true,
      );
    });

    test(
        "isFavoriteRestaurant returns false when restaurant is not in favorites",
        () {
      expect(
        favoriteRestaurantsCubit.isFavoriteRestaurant(testRestaurant),
        false,
      );
    });
  });
}
