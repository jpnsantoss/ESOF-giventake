import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final ProductRepo _productRepo;
  final UserRepository _userRepository;
  GetProductBloc(
    this._productRepo,
    this._userRepository,
  ) : super(GetProductInitial()) {
    on<GetProduct>((event, emit) async {
      emit(GetProductProcess());
      try {
        List<Product> products = await _productRepo.getProducts();
        for (Product product in products) {
          await product.fetchUser(_userRepository);
        }
        emit(GetProductSuccess(products));
      } catch (e) {
        emit(GetProductFailure());
      }
    });
  }
}
