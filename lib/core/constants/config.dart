import 'package:flutter_dotenv/flutter_dotenv.dart';

const String yelpGraphQLUrl = "https://api.yelp.com/v3/graphql";
final String yelpApiKey = dotenv.env['YELP_API_KEY'] ?? "";
