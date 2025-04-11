import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/location_entity.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  const LocationModel({
    this.formattedAddress,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  LocationEntity toEntity() => LocationEntity(
        formattedAddress: formattedAddress,
      );

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
