import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Product extends Equatable {
  final String productId;
  final String title;
  final String description;

  const Product({required this.productId, required this.title, required this.description});

  static const empty = Product(productId: '', title: '', description: '');

  Product copyWith({String? productId, String? title, String? description}) {
    return Product(
        productId: productId ?? this.productId,
        title: title ?? this.title,
        description: description ?? this.description);
  }

  ProductEntity toEntity() {
    return ProductEntity(productId: productId, title: title, description: description);
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(
        productId: entity.productId, title: entity.title, description: entity.description);
  }

  @override
  List<Object?> get props => [productId, title, description];
}
