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
        'image': product.image,
        'createdAt': product.createdAt,
        'solt': product.sold,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      return await productCollection.where('sold', isEqualTo: false).get().then(
          (value) => value.docs
              .map((e) =>
                  Product.fromEntity(ProductEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Product> getProduct(String productId) async {
    try {
      final querySnapshot =
          await productCollection.where('id', isEqualTo: productId).get();
      if (querySnapshot.docs.isNotEmpty) {
        final productEntity =
            ProductEntity.fromDocument(querySnapshot.docs.first.data());
        final product = Product.fromEntity(productEntity);
        return product;
      } else {
        // Product with the given ID not found
        throw Exception("Product with ID $productId not found");
      }
    } catch (e, stackTrace) {
      log("Error fetching product: $e\n$stackTrace");
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
          createdAt: doc['createdAt'],
        );
      }).toList();
    });
  }
}
