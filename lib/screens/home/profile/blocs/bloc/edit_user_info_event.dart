part of 'edit_user_info_bloc.dart';

sealed class EditUserInfoEvent extends Equatable {
  const EditUserInfoEvent();

  @override
  List<Object> get props => [];
}


class PickImageEvent extends EditUserInfoEvent {
  final ImageSource source;

  PickImageEvent(this.source);
}

class UpdateUserInfoEvent extends EditUserInfoEvent {
  final String userId;
  final String updatedBio;
  final String updatedName;
  final Uint8List? photo;
  


  UpdateUserInfoEvent(this.userId, this.updatedName, this.updatedBio,this.photo );
}