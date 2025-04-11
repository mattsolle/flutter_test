class GetRestaurantsQueryEntity {
  const GetRestaurantsQueryEntity({
    required this.offset,
    required this.favorites,
  });

  final int offset;
  final bool favorites;
}
