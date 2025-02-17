import 'package:core/core.dart';
import 'package:core/flutter_bloc.dart';

import '../data/models/bookmarks.dart';
import 'bookmarks_events.dart';
import 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  BookmarksBloc({
    required this.bookmarksRepo,
  }) : super(const BookmarksState(status: BookmarksStatus.loading)) {
    on<BookmarksEvent>((event, emit) => event.execute(this, emit));
  }

  final LocalRepository<Bookmarks> bookmarksRepo;
}

class BookmarksBlocProvider extends BlocProvider<BookmarksBloc> {
  BookmarksBlocProvider({
    super.key,
    super.child,
  }) : super(
          create: (context) {
            return BookmarksBloc(
              bookmarksRepo: di(),
            )..add(const FetchBookmarks());
          },
        );
}
