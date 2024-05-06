part of 'request_bloc.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestSuccess extends RequestState {
  final String message;

  RequestSuccess(this.message);
}

class RequestFailure extends RequestState {
  final String error;

  RequestFailure(this.error);
}