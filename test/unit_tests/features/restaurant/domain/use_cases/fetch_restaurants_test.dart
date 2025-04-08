import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_tour/features/restaurant/domain/use_cases/fetch_restaurants.dart';
import '../../../../../mocks.dart';

void main() {
  late FetchRestaurants useCase;
  late MockRestaurantRepository mockRepository;

  setUp(() {
    mockRepository = MockRestaurantRepository();
    useCase = FetchRestaurants(mockRepository);
  });

  const int offset = 0;

  test('should call fetchRestaurants on repository and return restaurants',
      () async {
    when(() => mockRepository.fetchRestaurants(any()))
        .thenAnswer((_) async => []);

    final result = await useCase.execute(offset);

    expect(result, isA<List>());
    verify(() => mockRepository.fetchRestaurants(offset)).called(1);
  });
}
