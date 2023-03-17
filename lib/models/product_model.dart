class ProductModel {
  final String name;
  final String price;
  final String description;
  final String image;
  final String id;
  bool isFavorite;

  ProductModel(
      {required this.name,
      required this.price,
      required this.description,
      required this.image,
      required this.id,
      this.isFavorite = false});
}
