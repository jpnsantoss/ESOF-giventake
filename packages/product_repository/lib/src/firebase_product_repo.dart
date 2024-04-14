import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_repository/src/models/product.dart';
import 'package:product_repository/src/product_repo.dart';

class FirebaseProductRepo implements ProductRepository {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
@override
  Future<void> addProduct(Product product) async {
    try {
      await productsCollection.add({
        'productId': product.productId,
        'title': product.title,
        'location': product.location,
        'desription': product.description,
        'imageLink' : product.imageLink,
      });
    } catch (e) {
      // Trate os erros de forma adequada
      print('Erro ao adicionar produto: $e');
      rethrow;
    }
  }

  /*@override
  Stream<List<Product>> getProducts() {
    // Implemente a lógica para obter os produtos, se necessário
    throw UnimplementedError();
  }*/
}