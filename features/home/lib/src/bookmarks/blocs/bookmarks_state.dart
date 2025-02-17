import 'package:equatable/equatable.dart';

import '../data/models/bookmarks.dart';

enum BookmarksStatus { loading, success, error }

class BookmarksState extends Equatable {
  const BookmarksState({
    required this.status,
    this.bookmarks = const Bookmarks(ids: []),
  });

  final BookmarksStatus status;
  final Bookmarks bookmarks;

  @override
  List get props => [status, bookmarks];

  BookmarksState copyWith({
    BookmarksStatus? status,
    Bookmarks? bookmarks,
  }) {
    return BookmarksState(
      status: status ?? this.status,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }
}
