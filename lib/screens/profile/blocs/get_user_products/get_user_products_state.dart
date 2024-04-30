part of 'get_user_products_bloc.dart';

sealed class GetUserProductsState extends Equatable {
  const GetUserProductsState();

  @override
  List<Object> get props => [];
}

final class GetUserProductsInitial extends GetUserProductsState {}

final class GetUserProductsFailure extends GetUserProductsState {}

final class GetUserProductsProcess extends GetUserProductsState {}

final class GetUserProductsSuccess extends GetUserProductsState {
  final List<Product> products;

  const GetUserProductsSuccess(this.products);

  @override
  List<Object> get props => [products];
}
