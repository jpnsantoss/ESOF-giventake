import 'package:product_repository/src/entities/product_entity.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String location;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
  });

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      location: location,
      image: image,
    );
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      location: entity.location,
      image: entity.image,
    );
  }
}
