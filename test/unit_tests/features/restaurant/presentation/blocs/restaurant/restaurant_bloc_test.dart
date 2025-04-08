import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_tour/features/restaurant/presentation/blocs/restaurant/restaurant_bloc.dart';
import '../../../../../../mocks.dart';

void main() {
  late RestaurantBloc bloc;
  late MockFetchRestaurants mockFetchRestaurants;
  late MockAppLogger mockLogger;

  setUp(() {
    mockFetchRestaurants = MockFetchRestaurants();
    mockLogger = MockAppLogger();
    bloc = RestaurantBloc(mockFetchRestaurants, mockLogger);
  });

  blocTest<RestaurantBloc, RestaurantState>(
    'emits [RestaurantLoading, RestaurantLoaded] when fetchRestaurants is successful',
    build: () {
      when(() => mockFetchRestaurants.execute(any()))
          .thenAnswer((_) async => []);
      return bloc;
    },
    act: (bloc) => bloc.add(FetchRestaurantsEvent(0)),
    expect: () => [RestaurantLoading(), RestaurantLoaded(const [])],
  );

  blocTest<RestaurantBloc, RestaurantState>(
    'emits [RestaurantLoading, RestaurantError] when fetchRestaurants fails',
    build: () {
      when(() => mockFetchRestaurants.execute(any()))
          .thenThrow(Exception("API Failure"));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchRestaurantsEvent(0)),
    expect: () =>
        [RestaurantLoading(), RestaurantError("Failed to fetch restaurants")],
  );
}
