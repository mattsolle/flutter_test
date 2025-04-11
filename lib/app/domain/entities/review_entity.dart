import 'user_entity.dart';

class ReviewEntity {
  const ReviewEntity({
    this.id,
    this.rating,
    this.user,
    this.text,
  });

  final String? id;
  final int? rating;
  final String? text;
  final UserEntity? user;
}
