import 'dart:developer';

import 'package:core/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/bookmarks.dart';
import 'bookmarks_bloc.dart';
import 'bookmarks_state.dart';

sealed class BookmarksEvent extends Equatable {
  const BookmarksEvent();

  Future<void> execute(BookmarksBloc bloc, Emitter<BookmarksState> emit);
}

final class FetchBookmarks extends BookmarksEvent {
  const FetchBookmarks();

  @override
  Future<void> execute(BookmarksBloc bloc, Emitter<BookmarksState> emit) async {
    try {
      final bookmarks = await bloc.bookmarksRepo.get();
      emit(
        bloc.state.copyWith(
          status: BookmarksStatus.success,
          bookmarks: bookmarks,
        ),
      );
      log('Fetch bookmarks (${bookmarks?.ids.length ?? 0} ids)');
    } catch (error) {
      log('Failed to fetch bookmarks: $error');
      emit(bloc.state.copyWith(status: BookmarksStatus.error));
    }
  }

  @override
  List get props => [];
}

final class AddToBookmarks extends BookmarksEvent {
  const AddToBookmarks({
    required this.id,
  });

  final String id;

  @override
  Future<void> execute(BookmarksBloc bloc, Emitter<BookmarksState> emit) async {
    try {
      final ids = bloc.state.bookmarks.ids.toList()..add(id);
      final bookmarks = Bookmarks(ids: ids);
      await bloc.bookmarksRepo.save(bookmarks);
      emit(
        bloc.state.copyWith(
          status: BookmarksStatus.success,
          bookmarks: bookmarks,
        ),
      );
      log('Add $id to bookmarks');
    } catch (error) {
      log('Failed to save bookmark: $error');
      emit(bloc.state.copyWith(status: BookmarksStatus.error));
    }
  }

  @override
  List get props => [id];
}

final class DeleteBookmark extends BookmarksEvent {
  const DeleteBookmark({
    required this.id,
  });

  final String id;

  @override
  Future<void> execute(BookmarksBloc bloc, Emitter<BookmarksState> emit) async {
    try {
      final ids = bloc.state.bookmarks.ids.toList()..remove(id);
      final bookmarks = Bookmarks(ids: ids);
      await bloc.bookmarksRepo.save(bookmarks);
      emit(
        bloc.state.copyWith(
          status: BookmarksStatus.success,
          bookmarks: bookmarks,
        ),
      );
      log('Delete $id from bookmarks');
    } catch (error) {
      log('Failed to delete bookmark: $error');
      emit(bloc.state.copyWith(status: BookmarksStatus.error));
    }
  }

  @override
  List get props => [id];
}
