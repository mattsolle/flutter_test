import 'package:core/flutter_bloc.dart';
import 'package:core/go_router.dart';
import 'package:design_system/design_system.dart';

import '../../bookmarks/blocs/bookmarks_bloc.dart';
import '../../bookmarks/blocs/bookmarks_events.dart';
import '../../bookmarks/blocs/bookmarks_state.dart';
import '../data/models/restaurant.dart';
import 'restaurant_screen.dart';

class RestaurantContainer extends BlocBuilder<BookmarksBloc, BookmarksState> {
  RestaurantContainer({
    super.key,
    required Restaurant restaurant,
  }) : super(
          builder: (context, state) {
            if (state.status == BookmarksStatus.loading) {
              return LoadingWidget(
                onBackPressed: context.pop,
              );
            } else {
              final bookmarked = state.bookmarks.ids.contains(restaurant.id);
              return RestaurantScreen(
                restaurant: restaurant,
                onBackPressed: context.pop,
                onLikePressed: () {
                  if (restaurant.id == null) return;

                  context.read<BookmarksBloc>().add(
                        bookmarked
                            ? DeleteBookmark(id: restaurant.id!)
                            : AddToBookmarks(id: restaurant.id!),
                      );
                },
                bookmarked: bookmarked,
              );
            }
          },
        );
}
