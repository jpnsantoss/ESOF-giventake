part of 'get_product_bloc.dart';

sealed class GetProductEvent extends Equatable {
  const GetProductEvent();

  @override
  List<Object> get props => [];
}

class GetProduct extends GetProductEvent {}

class SearchProduct extends GetProductEvent {
  final String query;

  const SearchProduct(this.query);

  @override
  List<Object> get props => [query];
}

class FetchAllProducts extends GetProductEvent {}
