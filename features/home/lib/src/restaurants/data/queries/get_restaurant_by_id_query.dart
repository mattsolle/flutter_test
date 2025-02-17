String getRestaurantByIdQuery(String id) => '''
  query getBusiness {
    business(id: "$id") {
        id
        name
        price
        rating
        photos
        reviews {
            id
            rating
            text
            user {
                id
                image_url
                name
            }
        }
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
  ''';
