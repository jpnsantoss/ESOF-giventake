import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String productId;
  final String title;
  final String location;
  final String description;
  final String image;

  const ProductEntity(
      {required this.productId, required this.title, required this.location, required this.description, required this.image});

  Map<String, Object?> toDocument() {
    return {
      'productId': productId,
      'title': title,
      'location': location,
      'description': description,
      'image' : image,
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
        productId: doc['productId'], title: doc['title'], location: doc['location'], description: doc['description'], image: doc['image']);
  }

  @override
  List<Object?> get props => [productId, title, location, description, image];
}