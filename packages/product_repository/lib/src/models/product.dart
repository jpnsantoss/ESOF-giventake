import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Product extends Equatable {
  final String productId;
  final String title;
  final String location;
  final String description;
  final String image;

  const Product({required this.productId, required this.title, required this.location, required this.description, required this.image});

  static const empty = Product(productId: '', title: '', location: '',description: '', image: '');

  Product copyWith({String? productId, String? title, String? description, String? image}) {
    return Product(
        productId: productId ?? this.productId,
        title: title ?? this.title,
        location: location ?? this.location,
        description: description ?? this.description,
        image: image ?? this.image);
  }

  ProductEntity toEntity() {
    return ProductEntity(productId: productId, title: title, location:location, description: description, image: image);
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(
        productId: entity.productId, title: entity.title, location:entity.location, description: entity.description, image: entity.image);
  }

  @override
  List<Object?> get props => [productId, title, location, description, image];
}
