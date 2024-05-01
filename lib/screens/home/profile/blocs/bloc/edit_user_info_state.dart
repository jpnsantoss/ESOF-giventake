part of 'edit_user_info_bloc.dart';

sealed class EditUserInfoState extends Equatable {
  const EditUserInfoState();
  
  @override
  List<Object> get props => [];
}

final class EditUserInfoInitial extends EditUserInfoState {}

final class EditUserInfoFailure extends EditUserInfoState {}

final class EditUserInfoProcess extends EditUserInfoState {}

final class EditUserInfoSuccess extends EditUserInfoState {}