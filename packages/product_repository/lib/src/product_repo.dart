import 'package:product_repository/src/models/product.dart';

abstract class ProductRepo {
  Future<List<Product>> getProducts();
}
