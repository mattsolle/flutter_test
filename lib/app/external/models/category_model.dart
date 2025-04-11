import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/category_entity.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  const CategoryModel({
    this.alias,
    this.title,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  final String? alias;
  final String? title;

  CategoryEntity toEntity() => CategoryEntity(
        alias: alias,
        title: title,
      );

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
