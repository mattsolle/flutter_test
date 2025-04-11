import '../../domain/query_entity/get_restaurants_query_entity.dart';

class GetRestaurantsQueryModel {
  const GetRestaurantsQueryModel({
    required this.offset,
    required this.favorites,
  });

  factory GetRestaurantsQueryModel.fromEntity(
    GetRestaurantsQueryEntity entity,
  ) {
    return GetRestaurantsQueryModel(
      offset: entity.offset,
      favorites: entity.favorites,
    );
  }

  final int offset;
  final bool favorites;

  String toQuery() {
    final query = {
      'location': '"Las Vegas"',
      'limit': 7,
      'offset': offset,
    };

    final queryString =
        query.entries.map((entry) => '${entry.key} : ${entry.value}').join(',');

    return '''
query getRestaurants {
  search($queryString) {
    total    
    business {
      id
      name
      price
      rating
      photos
      categories {
        title
        alias
      }
      hours {
        is_open_now
      }
      location {
        formatted_address
      }
    }
  }
}
  ''';
  }
}
