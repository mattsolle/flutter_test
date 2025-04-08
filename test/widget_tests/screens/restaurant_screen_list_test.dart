import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/features/restaurant/presentation/blocs/restaurant/restaurant_bloc.dart';
import 'package:restaurant_tour/features/restaurant/presentation/screens/restaurants_list_screen.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/restaurants_list.dart';

import '../../mocks.dart';

void main() {
  late MockRestaurantBloc mockRestaurantBloc;

  setUp(() {
    mockRestaurantBloc = MockRestaurantBloc();
  });

  Widget createTestWidget() {
    return BlocProvider<RestaurantBloc>.value(
      value: mockRestaurantBloc,
      child: const MaterialApp(
        home: RestaurantsListScreen(),
      ),
    );
  }

  testWidgets('Show loading indicator when state is loading', (tester) async {
    when(() => mockRestaurantBloc.state).thenReturn(RestaurantLoading());
    when(() => mockRestaurantBloc.stream)
        .thenAnswer((_) => Stream.value(RestaurantLoading()));

    await tester.pumpWidget(createTestWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Show empty message when no restaurants are available',
      (tester) async {
    when(() => mockRestaurantBloc.state).thenReturn(RestaurantInitial());
    when(() => mockRestaurantBloc.stream)
        .thenAnswer((_) => Stream.value(RestaurantInitial()));

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.noDataAvailable), findsOneWidget);
  });

  testWidgets('Display list when restaurants are available', (tester) async {
    final mockRestaurants = createMockRestaurants(3);

    when(() => mockRestaurantBloc.state)
        .thenReturn(RestaurantLoaded(mockRestaurants));
    when(() => mockRestaurantBloc.stream)
        .thenAnswer((_) => Stream.value(RestaurantLoaded(mockRestaurants)));

    await tester.pumpWidget(createTestWidget());

    expect(find.byType(RestaurantList), findsOneWidget);
  });

  testWidgets('Show error message when state is error', (tester) async {
    when(() => mockRestaurantBloc.state)
        .thenReturn(RestaurantError("Failed to load"));
    when(() => mockRestaurantBloc.stream)
        .thenAnswer((_) => Stream.value(RestaurantError("Failed to load")));

    await tester.pumpWidget(createTestWidget());

    expect(find.text("Failed to load"), findsOneWidget);
  });
}
