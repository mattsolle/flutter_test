import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/hours_entity.dart';

part 'hours_model.g.dart';

@JsonSerializable()
class HoursModel {
  const HoursModel({
    this.isOpenNow,
  });

  factory HoursModel.fromJson(Map<String, dynamic> json) =>
      _$HoursModelFromJson(json);

  @JsonKey(name: 'is_open_now')
  final bool? isOpenNow;

  HoursEntity toEntity() => HoursEntity(
        isOpenNow: isOpenNow,
      );

  Map<String, dynamic> toJson() => _$HoursModelToJson(this);
}
