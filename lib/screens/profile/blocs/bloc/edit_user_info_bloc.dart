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
  final String userId;

  EditUserInfoBloc(this.userId) : super(EditUserInfoInitial()){
    on<UpdateUserInfoEvent>((event, emit) async {
      MyUser user = await FirebaseUserRepo().getUser(userId);
      emit(EditUserInfoProcess(user));
      try {
        
        String name = event.updatedName;
        String bio = event.updatedBio;
        Uint8List? photo = event.photo;

        user = await FirebaseUserRepo().getUser(userId);

        if(event.updatedName == '') name=user.name;
        if(event.updatedBio == '') bio=user.bio;

        if(userId.isNotEmpty){
           String imageUrl = user.image;
            if (photo != null) {
            // Se uma nova foto for selecionada, faça o upload dela para o Firebase Storage
            imageUrl = await uploadImageToStorage('userImage_$userId', photo!);
          }

          // Atualize os dados do usuário no Firestore
          await FirebaseFirestore.instance.collection('users').doc(userId).update({
            'name': name,
            'email': user.email,
            'bio': bio,
            'image': imageUrl, 
          });


          await FirebaseAuth.instance.currentUser?.reload();
          await Future.delayed(Duration(seconds: 2)); 
           emit( EditUserInfoSuccess(photo!));
            }

        
      } catch (error) {
        emit(EditUserInfoFailure());
      }
  });

  on<PickImageUserEvent>((event, emit) async{
    MyUser user = await FirebaseUserRepo().getUser(userId);
    emit(EditUserInfoProcess(user));
      try {
        Uint8List? new_file;
        final ImagePicker picker = ImagePicker();
         XFile? file = await picker.pickImage(source: ImageSource.gallery);
         if (file != null) {
        new_file = await file.readAsBytes();
        }

        if (new_file != null) {
          Uint8List photo = new_file;

          
          emit (EditUserInfoSuccess(photo));


        } else {
          emit(EditUserInfoFailure());
        }
      } catch (error) {
        emit(EditUserInfoFailure());
      }      
  });
  }


  Future<String> uploadImageToStorage(String imagePath, Uint8List file) async {
    Reference ref = _storage.ref().child(imagePath);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  
}

