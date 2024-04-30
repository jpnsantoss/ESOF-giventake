part of 'request_bloc.dart';

abstract class RequestEvent {}

class AcceptRequest extends RequestEvent {
  final String requestId;

  AcceptRequest(this.requestId);
}

class RejectRequest extends RequestEvent {
  final String requestId;

  RejectRequest(this.requestId);
}