import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:request_repository/request_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, List<Request>> {
  RequestBloc() : super([]);

  final requestCollection = FirebaseFirestore.instance.collection('requests');

  @override
  Stream<List<Request>> mapEventToState(RequestEvent event) async* {
    if (event is AcceptRequestEvent) {
      await acceptRequest(event.requestId);
      // Optionally, you can emit a new state here with the updated list of requests
    } else if (event is RejectRequestEvent) {
      // Handle rejecting request
      await rejectRequest(event.requestId);
      // Emit a new state with the updated list of requests after rejection
      yield* _mapRejectRequestToState(event.requestId);
    }
  }

  Stream<List<Request>> _mapRejectRequestToState(String requestId) async* {
    // Filter out the rejected request from the current state
    final updatedRequests = state.where((request) => request.id != requestId).toList();
    yield updatedRequests;
  }

  Future<void> acceptRequest(String requestId) async {
    try {
      await requestCollection.doc(requestId).update({
        'accepted': true,
      });
    } catch (e) {
      throw 'Failed to accept request: $e';
    }
  }

  Future<void> rejectRequest(String requestId) async {
    try {
      await requestCollection.doc(requestId).delete();
    } catch (e) {
      throw Exception('Failed to reject request: $e');
    }
  }
}
