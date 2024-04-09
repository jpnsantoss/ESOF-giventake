
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication__event.dart';
part 'authentication__state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
