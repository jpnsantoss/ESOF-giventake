import 'package:product_repository/src/models/product.dart';

abstract class ProductRepo {
  Future<void> addProduct(Product product); 
  Future<List<Product>> getProducts();

}
