import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_tour/features/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_tour/features/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_tour/features/restaurant/data/models/restaurant.dart';
import '../../../../../mocks.dart';

void main() {
  late RestaurantRepository repository;
  late MockApiClient mockApiClient;
  late MockAppLogger mockLogger;

  setUp(() {
    mockApiClient = MockApiClient();
    mockLogger = MockAppLogger();
    repository = RestaurantRepositoryImpl(mockApiClient, mockLogger);
  });

  const int offset = 0;
  const mockResponse = {
    "data": {
      "search": {
        "business": [
          {"id": "1", "name": "Test Restaurant"},
        ],
      },
    },
  };

  test('should return list of Restaurant when API call is successful',
      () async {
    when(() => mockApiClient.postRequest(any()))
        .thenAnswer((_) async => mockResponse);

    final result = await repository.fetchRestaurants(offset);

    expect(result, isA<List<Restaurant>>());
    expect(result.first.name, "Test Restaurant");
  });

  test('should log error and return mock data on failure', () async {
    when(() => mockApiClient.postRequest(any()))
        .thenThrow(Exception("API failure"));

    final result = await repository.fetchRestaurants(offset);

    verify(
      () => mockLogger.logError(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).called(1);

    expect(result, isA<List<Restaurant>>());
  });
}
