import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/restaurant_entity.dart';
import 'category_model.dart';
import 'hours_model.dart';
import 'location_model.dart';
import 'review_model.dart';

part 'restaurant_model.g.dart';

@JsonSerializable()
class RestaurantModel {
  const RestaurantModel({
    this.id,
    this.name,
    this.price,
    this.rating,
    this.photos,
    this.categories,
    this.hours,
    this.reviews,
    this.location,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final List<String>? photos;
  final List<CategoryModel>? categories;
  final List<HoursModel>? hours;
  final List<ReviewModel>? reviews;
  final LocationModel? location;

  RestaurantEntity toEntity() => RestaurantEntity(
        id: id,
        name: name,
        price: price,
        rating: rating,
        photos: photos,
        categories: categories?.map((e) => e.toEntity()).toList(),
        hours: hours?.map((e) => e.toEntity()).toList(),
        reviews: reviews?.map((e) => e.toEntity()).toList(),
        location: location?.toEntity(),
      );

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}
