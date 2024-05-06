
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';


enum ProductStatus { loading, loaded, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<Product> products;
  final String? errorMessage;

  const ProductState({
    required this.status,
    required this.products,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, products, errorMessage];
}