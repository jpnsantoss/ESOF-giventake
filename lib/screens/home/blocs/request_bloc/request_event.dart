part of 'request_bloc.dart';

abstract class RequestEvent {}

class AcceptRequestEvent extends RequestEvent {
  final String requestId;

  AcceptRequestEvent(this.requestId);
}

class RejectRequestEvent extends RequestEvent {
  final String requestId;

  RejectRequestEvent(this.requestId);
}