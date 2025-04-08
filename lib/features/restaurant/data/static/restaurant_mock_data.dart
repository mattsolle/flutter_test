const Map<String, dynamic> mockRestaurantResponse = {
  "data": {
    "search": {
      "total": 5,
      "business": [
        {
          "id": "restaurant-1",
          "name": "Best Restaurant",
          "price": "\$\$",
          "rating": 4.5,
          "photos": ["https://example.com/image1.jpg"],
          "reviews": [
            {
              "id": "review-1",
              "rating": 5,
              "text": "Amazing food!",
              "user": {
                "id": "user-1",
                "image_url": "https://example.com/user1.jpg",
                "name": "John Doe",
              },
            },
            {
              "id": "review-2",
              "rating": 3,
              "text": "Food is good",
              "user": {
                "id": "user-1",
                "image_url": "https://example.com/user1.jpg",
                "name": "John Doe1",
              },
            }
          ],
          "categories": [
            {"title": "Italian", "alias": "italian"},
          ],
          "hours": [
            {"is_open_now": true},
          ],
          "location": {
            "formatted_address": "123 Main St, Las Vegas, NV",
          },
        },
        {
          "id": "restaurant-2",
          "name": "Tasty Eats",
          "price": "\$\$\$",
          "rating": 4.0,
          "photos": ["https://example.com/image2.jpg"],
          "reviews": [
            {
              "id": "review-2",
              "rating": 4,
              "text": "Great ambiance!",
              "user": {
                "id": "user-2",
                "image_url": "https://example.com/user2.jpg",
                "name": "Jane Smith",
              },
            }
          ],
          "categories": [
            {"title": "Steakhouse", "alias": "steakhouse"},
          ],
          "hours": [
            {"is_open_now": false},
          ],
          "location": {
            "formatted_address": "456 Another St, Las Vegas, NV",
          },
        },
        {
          "id": "restaurant-3",
          "name": "Ocean Delights",
          "price": "\$\$\$",
          "rating": 4.7,
          "photos": ["https://example.com/image3.jpg"],
          "reviews": [
            {
              "id": "review-3",
              "rating": 5,
              "text": "Fresh seafood, highly recommended!",
              "user": {
                "id": "user-3",
                "image_url": "https://example.com/user3.jpg",
                "name": "Michael Lee",
              },
            }
          ],
          "categories": [
            {"title": "Seafood", "alias": "seafood"},
          ],
          "hours": [
            {"is_open_now": true},
          ],
          "location": {
            "formatted_address": "789 Ocean Blvd, San Francisco, CA",
          },
        },
        {
          "id": "restaurant-4",
          "name": "Spicy House",
          "price": "\$",
          "rating": 3.8,
          "photos": ["https://example.com/image4.jpg"],
          "reviews": [
            {
              "id": "review-4",
              "rating": 3,
              "text": "Good food, but a bit too spicy for me.",
              "user": {
                "id": "user-4",
                "image_url": "https://example.com/user4.jpg",
                "name": "Emily Davis",
              },
            }
          ],
          "categories": [
            {"title": "Indian", "alias": "indian"},
          ],
          "hours": [
            {"is_open_now": false},
          ],
          "location": {
            "formatted_address": "101 Curry St, New York, NY",
          },
        },
        {
          "id": "restaurant-5",
          "name": "Burger Kingdom",
          "price": "\$",
          "rating": 4.2,
          "photos": ["https://example.com/image5.jpg"],
          "reviews": [
            {
              "id": "review-5",
              "rating": 4,
              "text": "Great burgers and fries!",
              "user": {
                "id": "user-5",
                "image_url": "https://example.com/user5.jpg",
                "name": "Chris Brown",
              },
            }
          ],
          "categories": [
            {"title": "Fast Food", "alias": "fastfood"},
          ],
          "hours": [
            {"is_open_now": true},
          ],
          "location": {
            "formatted_address": "202 King St, Los Angeles, CA",
          },
        }
      ],
    },
  },
};
