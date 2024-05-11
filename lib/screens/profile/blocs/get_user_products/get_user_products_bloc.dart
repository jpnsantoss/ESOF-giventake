import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';

part 'get_user_products_event.dart';
part 'get_user_products_state.dart';

class GetUserProductsBloc
    extends Bloc<GetUserProductsEvent, GetUserProductsState> {
  final ProductRepo _productRepo;

  GetUserProductsBloc(this._productRepo) : super(GetUserProductsInitial()) {
    on<GetUserProducts>(getUserProducts);
  }

  Future<void> getUserProducts(
      GetUserProducts event, Emitter<GetUserProductsState> emit) async {
    emit(GetUserProductsProcess());
    try {
      final products = await _productRepo.getUserProducts(event.userId);
      emit(GetUserProductsSuccess(products));
    } catch (e) {
      emit(GetUserProductsFailure());
    }
  }
}
