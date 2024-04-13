import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String productId;
  final String title;
  final String description;

  const ProductEntity(
      {required this.productId, required this.title, required this.description});

  Map<String, Object?> toDocument() {
    return {
      'productId': productId,
      'title': title,
      'description': description,
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
        productId: doc['productId'], title: doc['title'], description: doc['description']);
  }

  @override
  List<Object?> get props => [productId, title, description];
}