part of 'upload_product_bloc.dart';

sealed class UploadProductEvent extends Equatable {
  const UploadProductEvent();

  @override
  List<Object> get props => [];

}

class PickImageEvent extends UploadProductEvent {
  final ImageSource source;

  PickImageEvent(this.source);
}

class UploadNewProductEvent extends UploadProductEvent {
  final String descrition;
  final String location;
  final String title;
  final Uint8List? photo;
  


  UploadNewProductEvent(this.descrition, this.location,this.title, this.photo, );
}