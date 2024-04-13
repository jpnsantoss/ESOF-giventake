import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Product extends Equatable {
  final String productId;
  final String title;
  final String location;
  final String description;

  const Product({required this.productId, required this.title, required this.location, required this.description});

  static const empty = Product(productId: '', title: '', location: '',description: '');

  Product copyWith({String? productId, String? title, String? description}) {
    return Product(
        productId: productId ?? this.productId,
        title: title ?? this.title,
        location: location ?? this.location,
        description: description ?? this.description);
  }

  ProductEntity toEntity() {
    return ProductEntity(productId: productId, title: title, location:location, description: description);
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(
        productId: entity.productId, title: entity.title, location:entity.location, description: entity.description);
  }

  @override
  List<Object?> get props => [productId, title, location, description];
}
