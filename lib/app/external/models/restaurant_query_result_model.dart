import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/restaurant_query_result_entity.dart';
import 'restaurant_model.dart';

part 'restaurant_query_result_model.g.dart';

@JsonSerializable()
class RestaurantQueryResultModel {
  const RestaurantQueryResultModel({
    this.total,
    this.business,
  });

  factory RestaurantQueryResultModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantQueryResultModelFromJson(json);

  final int? total;
  final List<RestaurantModel>? business;

  RestaurantQueryResultEntity toEntity() => RestaurantQueryResultEntity(
        total: total,
        restaurants: business?.map((e) => e.toEntity()).toList(),
      );

  Map<String, dynamic> toJson() => _$RestaurantQueryResultModelToJson(this);
}
