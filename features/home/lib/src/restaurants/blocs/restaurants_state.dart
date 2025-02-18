import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/models/restaurant.dart';

enum RestaurantsStatus { loading, success, error, yelpLimit }

class RestaurantsState extends Equatable {
  const RestaurantsState({
    required this.status,
    required this.controller,
    this.offset = 0,
  });

  final RestaurantsStatus status;
  final PagingController<int, Restaurant> controller;
  final int offset;

  @override
  List get props => [status, controller, offset];

  RestaurantsState copyWith({
    RestaurantsStatus? status,
    int? offset,
    int? total,
  }) {
    return RestaurantsState(
      status: status ?? this.status,
      offset: offset ?? this.offset,
      controller: controller,
    );
  }
}
