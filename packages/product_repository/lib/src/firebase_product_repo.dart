import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_repository/src/entities/product_entity.dart';
import 'package:product_repository/src/models/product.dart';
import 'package:product_repository/src/product_repo.dart';

class FirebaseProductRepo implements ProductRepo {
  final productCollection = FirebaseFirestore.instance.collection('products');

  @override
  Future<void> addProduct(Product product) async {
    try {
      await productCollection.add({
        'productId': product.id,
        'title': product.title,
        'location': product.location,
        'description': product.description,
        'image' : product.image,

      });
    } catch (e) {
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

  @override
  Future<List<Product>> getUserProducts(String userId) {
    return productCollection
        .where('userId', isEqualTo: userId)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        return Product(
          id: doc.id,
          title: doc['title'],
          location: doc['location'],
          description: doc['description'],
          image: doc['image'],
          userId: doc['userId'],
        );
      }).toList();
    });
  }
}
