part of 'edit_user_info_bloc.dart';

sealed class EditUserInfoEvent extends Equatable {
  const EditUserInfoEvent();

  @override
  List<Object> get props => [];
}

class EditUserInfo extends EditUserInfoEvent {
  final MyUser user;

  const EditUserInfo(this.user);

  @override
  List<Object> get props => [user];
}