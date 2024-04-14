import 'package:product_repository/src/entities/product_entity.dart';
import 'package:user_repository/user_repository.dart';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String location;
  final String image;
  final String userId;
  MyUser? user;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
    required this.userId,
  });

  Future<void> fetchUser(UserRepository userRepository) async {
    user = await userRepository.getUser(userId);
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      location: location,
      image: image,
      userId: userId,
    );
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(

      id: entity.id,
      title: entity.title,
      description: entity.description,
      location: entity.location,
      image: entity.image,
      userId: entity.userId,
    );
  }
}
