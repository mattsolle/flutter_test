import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({
    this.id,
    this.imageUrl,
    this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  final String? id;

  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? name;

  UserEntity toEntity() => UserEntity(
        id: id,
        imageUrl: imageUrl,
        name: name,
      );

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
