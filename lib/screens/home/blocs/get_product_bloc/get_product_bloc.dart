
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  GetProductBloc() : super(GetProductInitial()) {
    on<GetProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
