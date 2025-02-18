import 'dart:developer';

import 'package:core/core.dart';
import 'package:core/flutter_bloc.dart';

import '../../bookmarks/data/models/bookmarks.dart';
import '../data/models/exceptions.dart';
import '../data/repositories/restaurants_repository.dart';
import 'bookmarked_restaurants_state.dart';

class BookmarkedRestaurantsCubit extends Cubit<BookmarkedRestaurantsState> {
  BookmarkedRestaurantsCubit({
    required this.bookmarksRepo,
    required this.restaurantsRepository,
  }) : super(
          const BookmarkedRestaurantsState(
            status: BookmarkedRestaurantsStatus.idle,
          ),
        );

  final LocalRepository<Bookmarks> bookmarksRepo;
  final RestaurantsRepository restaurantsRepository;

  Future<void> fetchRestaurants() async {
    try {
      emit(
        const BookmarkedRestaurantsState(
          status: BookmarkedRestaurantsStatus.loading,
        ),
      );
      final bookmarks = await bookmarksRepo.get();
      if (bookmarks == null) return;

      final restaurants = state.restaurants.toList();
      for (final id in bookmarks.ids) {
        final restaurant = await restaurantsRepository.getRestaurantById(id);
        if (restaurant != null) {
          restaurants.add(restaurant);
        }
      }

      if (restaurants.isEmpty) {
        emit(state.copyWith(status: BookmarkedRestaurantsStatus.empty));
      } else {
        emit(
          state.copyWith(
            status: BookmarkedRestaurantsStatus.success,
            restaurants: restaurants,
          ),
        );
      }
    } on YelpRateLimitException catch (_) {
      emit(state.copyWith(status: BookmarkedRestaurantsStatus.yelpLimit));
    } catch (error) {
      log('Failed to fetch restaurants');
      emit(state.copyWith(status: BookmarkedRestaurantsStatus.error));
    }
  }
}

class BookmarkedRestaurantsCubitProvider
    extends BlocProvider<BookmarkedRestaurantsCubit> {
  BookmarkedRestaurantsCubitProvider({
    super.key,
    super.child,
  }) : super(
          create: (context) {
            return BookmarkedRestaurantsCubit(
              bookmarksRepo: di(),
              restaurantsRepository: di(),
            )..fetchRestaurants();
          },
        );
}
