import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String productId;
  final String title;
  final String location;
  final String description;
  final Uint8List imageLink;

  const ProductEntity(
      {required this.productId, required this.title, required this.location, required this.description, required this.imageLink});

  Map<String, Object?> toDocument() {
    return {
      'productId': productId,
      'title': title,
      'location': location,
      'description': description,
      'imageLink' : imageLink,
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
        productId: doc['productId'], title: doc['title'], location: doc['location'], description: doc['description'], imageLink: doc['imageLink']);
  }

  @override
  List<Object?> get props => [productId, title, location, description, imageLink];
}