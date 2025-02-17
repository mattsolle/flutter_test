import 'package:equatable/equatable.dart';

import '../../restaurants/data/models/restaurant.dart';
import '../data/models/bookmarks.dart';

enum BookmarksStatus { loading, success, error }

class BookmarksState extends Equatable {
  const BookmarksState({
    required this.status,
    this.bookmarks = const Bookmarks(ids: []),
    this.bookmarkedRestaurants = const [],
  });

  final BookmarksStatus status;
  final Bookmarks bookmarks;
  final List<Restaurant> bookmarkedRestaurants;

  @override
  List get props => [status, bookmarks, bookmarkedRestaurants];

  BookmarksState copyWith({
    BookmarksStatus? status,
    Bookmarks? bookmarks,
    List<Restaurant>? bookmarkedRestaurants,
  }) {
    return BookmarksState(
      status: status ?? this.status,
      bookmarks: bookmarks ?? this.bookmarks,
      bookmarkedRestaurants:
          bookmarkedRestaurants ?? this.bookmarkedRestaurants,
    );
  }
}
