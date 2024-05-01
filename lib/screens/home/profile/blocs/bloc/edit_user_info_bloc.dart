import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'edit_user_info_event.dart';
part 'edit_user_info_state.dart';

class EditUserInfoBloc
    extends Bloc<EditUserInfoEvent, EditUserInfoState> {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  EditUserInfoBloc() : super(EditUserInfoInitial());

 @override
  Stream<EditUserInfoState> mapEventToState(EditUserInfoEvent event) async* {
    if (event is PickImageEvent) {
      yield EditUserInfoProcess();
      try {
        XFile? file = await _picker.pickImage(source: event.source);
        if (file != null) {
          Uint8List imageBytes = await file.readAsBytes();
          yield EditUserInfoSuccess();
        } else {
          yield EditUserInfoFailure();
        }
      } catch (error) {
        yield EditUserInfoFailure();
      }
    } else if (event is UpdateUserInfoEvent) {
      yield EditUserInfoProcess();
      try {
        // Implemente a lógica de atualização das informações do usuário aqui
        yield EditUserInfoSuccess();
      } catch (error) {
        yield EditUserInfoFailure();
      }
    }
  }
}

