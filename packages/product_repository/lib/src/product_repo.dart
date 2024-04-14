
import 'package:firebase_auth/firebase_auth.dart';
import 'models/models.dart';

class Awesome {
  bool get isAwesome => true;
}

abstract class ProductRepository {
  //Stream<List<Product>> getProducts();

  Future<void> addProduct(Product product); 
}
