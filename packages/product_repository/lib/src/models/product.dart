import 'package:product_repository/src/entities/product_entity.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      image: image,
    );
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      image: entity.image,
    );
  }
}
