import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_repository/src/entities/product_entity.dart';
import 'package:product_repository/src/models/product.dart';
import 'package:product_repository/src/product_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProductRepo implements ProductRepo {
  final productCollection = FirebaseFirestore.instance.collection('products');

  @override
  Future<void> addProduct(Product product) async {
    try {
      await productsCollection.add({
        'productId': product.productId,
        'title': product.title,
        'location': product.location,
        'desription': product.description,
        'image' : product.image,
      });
    } catch (e) {
      // Trate os erros de forma adequada
      print('Erro ao adicionar produto: $e');
      rethrow;
    }
  }
  @override
  Future<List<Product>> getProducts() async {
    try {
      return await productCollection.get().then((value) => value.docs
          .map((e) => Product.fromEntity(ProductEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}