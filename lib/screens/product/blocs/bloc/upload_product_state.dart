part of 'upload_product_bloc.dart';

sealed class UploadProductState extends Equatable {
  const UploadProductState();
  
  @override
  List<Object> get props => [];
}

final class UploadProductInitial extends UploadProductState {}

final class UploadProductFailure extends UploadProductState {}

final class UploadProductProcess extends UploadProductState {
}

final class UploadProductSuccess extends UploadProductState {}