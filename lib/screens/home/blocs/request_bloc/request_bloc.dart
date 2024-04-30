import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:request_repository/request_repository.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestRepo repository;

  RequestBloc(this.repository) : super(RequestInitial());

  @override
  Stream<RequestState> mapEventToState(RequestEvent event) async* {
    if (event is AcceptRequest) {
      yield RequestLoading();
      try {
        await repository.acceptRequest(event.requestId);
        yield RequestSuccess('Request accepted successfully');
      } catch (e) {
        yield RequestFailure(e.toString());
      }
    } else if (event is RejectRequest) {
      yield RequestLoading();
      try {
        await repository.rejectRequest(event.requestId);
        yield RequestSuccess('Request rejected successfully');
      } catch (e) {
        yield RequestFailure(e.toString());
      }
    }
  }
}