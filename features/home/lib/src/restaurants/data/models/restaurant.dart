import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Category {
  Category({
    this.alias,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  final String? alias;
  final String? title;

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Hours {
  const Hours({
    this.isOpenNow,
  });

  factory Hours.fromJson(Map<String, dynamic> json) => _$HoursFromJson(json);

  @JsonKey(name: 'is_open_now')
  final bool? isOpenNow;

  Map<String, dynamic> toJson() => _$HoursToJson(this);
}

@JsonSerializable()
class User {
  const User({
    this.id,
    this.imageUrl,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String? id;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? name;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Review {
  const Review({
    this.id,
    this.rating,
    this.user,
    this.text,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  final String? id;
  final int? rating;
  final String? text;
  final User? user;

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class Location {
  Location({
    this.formattedAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Restaurant {
  const Restaurant({
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

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final List<String>? photos;
  final List<Category>? categories;
  final List<Hours>? hours;
  final List<Review>? reviews;
  final Location? location;

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  /// Use the first category for the category shown to the user
  String get displayCategory {
    if (categories != null && categories!.isNotEmpty) {
      return categories!.first.title ?? '';
    }
    return '';
  }

  /// Use the first image as the image shown to the user
  String get heroImage {
    if (photos != null && photos!.isNotEmpty) {
      return photos!.first;
    }
    return '';
  }

  /// This logic is probably not correct in all cases but it is ok
  /// for this application
  bool get isOpen {
    if (hours != null && hours!.isNotEmpty) {
      return hours!.first.isOpenNow ?? false;
    }
    return false;
  }
}

@JsonSerializable()
class RestaurantQueryResult {
  const RestaurantQueryResult({
    this.total,
    this.restaurants,
  });

  factory RestaurantQueryResult.fromJson(Map<String, dynamic> json) =>
      _$RestaurantQueryResultFromJson(json);

  final int? total;
  @JsonKey(name: 'business')
  final List<Restaurant>? restaurants;

  Map<String, dynamic> toJson() => _$RestaurantQueryResultToJson(this);
}
