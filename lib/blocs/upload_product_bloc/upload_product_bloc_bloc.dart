import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_repository/product_repository.dart';
//import 'package:product_repository/models/product.dart';

part 'upload_product_bloc_event.dart';
part 'upload_product_bloc_state.dart';

class ProductBloc extends Bloc<UploadProductBlocEvent, ProductState> {
  final ProductRepo productRepository;

  ProductBloc(this.productRepository) : super(ProductState(status: ProductStatus.loading, products: [])) {
    on<AddProduct>(_addProduct);
    // Implementar tratamento de outros eventos aqui
  }
  void _addProduct(AddProduct event, Emitter<ProductState> emit) {
    // Lógica para adicionar o produto
    // Por exemplo, chamar uma função no repositório para adicionar o produto
    try {
      final newProductList = List.from(state.products)..add(event.product);
      emit(ProductState(status: ProductStatus.loaded, products: newProductList));
    } catch (e) {
      emit(ProductState(status: ProductStatus.error, products: state.products, errorMessage: 'Failed to add product.'));
    }
  }
}