
import 'package:firebase_auth/firebase_auth.dart';
import 'models/models.dart';

abstract class ProductRepository {
  //Stream<List<Product>> getProducts();

  Future<void> addProduct(Product product); 
}
