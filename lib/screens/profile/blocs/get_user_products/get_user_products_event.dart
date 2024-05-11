part of 'get_user_products_bloc.dart';

sealed class GetUserProductsEvent extends Equatable {
  const GetUserProductsEvent();

  @override
  List<Object> get props => [];
}

class GetUserProducts extends GetUserProductsEvent {
  final String userId;

  const GetUserProducts(this.userId);

  @override
  List<Object> get props => [userId];
}
