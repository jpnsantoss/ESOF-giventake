part of 'upload_product_bloc_bloc.dart';

sealed class UploadProductBlocEvent extends Equatable {
  const UploadProductBlocEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends UploadProductBlocEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}