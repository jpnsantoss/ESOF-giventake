import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Product extends Equatable {
  final String productId;
  final String title;
  final String location;
  final String description;
  final Uint8List imageLink;

  const Product({required this.productId, required this.title, required this.location, required this.description, required this.imageLink});

  //static const empty = Product(productId: '', title: '', location: '',description: '');

  Product copyWith({String? productId, String? title, String? description, Uint8List? imageLink}) {
    return Product(
        productId: productId ?? this.productId,
        title: title ?? this.title,
        location: location ?? this.location,
        description: description ?? this.description,
        imageLink: imageLink ?? this.imageLink);
  }

  ProductEntity toEntity() {
    return ProductEntity(productId: productId, title: title, location:location, description: description, imageLink: imageLink);
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(
        productId: entity.productId, title: entity.title, location:entity.location, description: entity.description, imageLink: entity.imageLink);
  }

  @override
  List<Object?> get props => [productId, title, location, description, imageLink];
}
