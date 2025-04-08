import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_tour/core/constants/app_colors.dart';
import 'package:restaurant_tour/core/constants/app_strings.dart';
import 'package:restaurant_tour/features/restaurant/presentation/cubits/favourite_restaurants/favourite_restaurants_cubit.dart';
import 'package:restaurant_tour/features/restaurant/presentation/screens/favourite_restaurants_screen.dart';
import 'package:restaurant_tour/features/restaurant/presentation/widgets/restaurant_list_item_widget.dart';

import '../../mocks.dart';

void main() {
  late MockFavoriteRestaurantsCubit mockCubit;

  setUp(() {
    mockCubit = MockFavoriteRestaurantsCubit();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<FavoriteRestaurantsCubit>.value(
      value: mockCubit,
      child: const MaterialApp(
        home: FavoriteRestaurantsScreen(),
      ),
    );
  }

  testWidgets('Show loading indicator when state is initial', (tester) async {
    when(() => mockCubit.state).thenReturn(FavoriteRestaurantsInitial());
    when(() => mockCubit.stream).thenAnswer(
      (_) => Stream.value(FavoriteRestaurantsInitial()),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Show empty message when no favorite restaurants',
      (tester) async {
    when(() => mockCubit.state).thenReturn(const FavoriteRestaurantsLoaded([]));
    when(() => mockCubit.stream).thenAnswer(
      (_) => Stream.value(const FavoriteRestaurantsLoaded([])),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text(AppStrings.noFavouriteRestaurants), findsOneWidget);
  });

  testWidgets('Display list when favorite restaurants are available',
      (tester) async {
    final mockRestaurants = createMockRestaurants(3);

    when(() => mockCubit.state)
        .thenReturn(FavoriteRestaurantsLoaded(mockRestaurants));
    when(() => mockCubit.stream).thenAnswer(
      (_) => Stream.value(FavoriteRestaurantsLoaded(mockRestaurants)),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(RestaurantListItemWidget), findsNWidgets(3));
  });

  testWidgets('Show error message when state is error', (tester) async {
    when(() => mockCubit.state)
        .thenReturn(const FavoriteRestaurantsError("Failed to load"));
    when(() => mockCubit.stream).thenAnswer(
      (_) => Stream.value(const FavoriteRestaurantsError("Failed to load")),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text("Error: Failed to load"), findsOneWidget);
  });

  testWidgets('Display correct styles for error message', (tester) async {
    when(() => mockCubit.state)
        .thenReturn(const FavoriteRestaurantsError("Network Issue"));
    when(() => mockCubit.stream).thenAnswer(
      (_) => Stream.value(const FavoriteRestaurantsError("Network Issue")),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    final errorTextFinder = find.text("Error: Network Issue");
    expect(errorTextFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(errorTextFinder);
    expect(textWidget.style?.color, AppColors.error);
  });
}
