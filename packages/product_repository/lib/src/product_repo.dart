import 'package:product_repository/src/models/product.dart';

abstract class ProductRepo {
  Future<void> addProduct(Product product);
  Future<List<Product>> getProducts();
  Future<List<Product>> getUserProducts(String userId);
  Future<Product> getProduct(String productId);
}
