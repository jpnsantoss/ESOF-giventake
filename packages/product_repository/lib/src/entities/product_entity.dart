import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String productId;
  final String title;
  final String location;
  final String description;

  const ProductEntity(
      {required this.productId, required this.title, required this.location, required this.description});

  Map<String, Object?> toDocument() {
    return {
      'productId': productId,
      'title': title,
      'location': location,
      'description': description,
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
        productId: doc['productId'], title: doc['title'], location: doc['location'], description: doc['description']);
  }

  @override
  List<Object?> get props => [productId, title, location, description];
}