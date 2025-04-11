import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/review_entity.dart';
import 'user_model.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  const ReviewModel({
    this.id,
    this.rating,
    this.user,
    this.text,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  final String? id;
  final int? rating;
  final String? text;
  final UserModel? user;

  ReviewEntity toEntity() => ReviewEntity(
        id: id,
        rating: rating,
        text: text,
        user: user?.toEntity(),
      );

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
