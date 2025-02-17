import 'dart:convert';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class Bookmarks extends Equatable implements JsonModel {
  const Bookmarks({
    required this.ids,
  });

  factory Bookmarks.fromMap(Map<String, dynamic> map) {
    return Bookmarks(
      ids: (map['ids'] as List).map((e) => e.toString()).toList(),
    );
  }

  factory Bookmarks.fromJson(String source) =>
      Bookmarks.fromMap(json.decode(source) as Map<String, dynamic>);

  final List<String> ids;

  @override
  List get props => [ids];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ids': ids,
    };
  }

  @override
  String toJson() => json.encode(toMap());
}
