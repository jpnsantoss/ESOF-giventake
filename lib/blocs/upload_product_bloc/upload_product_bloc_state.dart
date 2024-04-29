part of 'upload_product_bloc_bloc.dart';

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