import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

part 'upload_product_event.dart';
part 'upload_product_state.dart';

class UploadProductBloc extends Bloc<UploadProductEvent, UploadProductState> {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  

  UploadProductBloc() : super(UploadProductInitial()) {
    on<UploadNewProductEvent>((event, emit) async {
      emit(UploadProductProcess());
      try{
        
          
          String title = event.title;
          String location = event.location;
          String description = event.descrition;
          Uint8List? photo = event.photo;

          String resp = await saveProductToFirestore(
              title: title,
              location: location,
              description: description,
              file: photo!);
          if(resp == 'sucess'){
            emit( UploadProductSuccess());
            }
          }
          catch(error){
            emit(UploadProductFailure());
          }
    });

    on<PickImageEvent>((event, emit) async{

    emit(UploadProductProcess());
      try {
        Uint8List? new_file;
        final ImagePicker picker = ImagePicker();
         XFile? file = await picker.pickImage(source: ImageSource.gallery);
         if (file != null) {
        new_file = await file.readAsBytes();
        }

        if (new_file != null) {
          Uint8List photo = new_file;
          emit (UploadProductSuccess());


        } else {
          emit(UploadProductFailure());
        }
      } catch (error) {
        emit(UploadProductFailure());
      }      
  });
  }
  
  Future<String> saveProductToFirestore({required String title, required String location, required String description, required Uint8List file}) async {
    
    String res = "Some error occurred";
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      String id = const Uuid().v4();
      String imageName = 'productImage_$id';

      if (title.isNotEmpty ||
          location.isNotEmpty ||
          description.isNotEmpty ||
          file.isNotEmpty) {
        String imageUrl = await uploadImageToStorage(imageName, file);
        await _firestore.collection('products').add({
          'id': id,
          'userId': userId,
          'title': title,
          'location': location,
          'description': description,
          'image': imageUrl,
        });

        res = 'sucess';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  
  }

  Future<String> uploadImageToStorage(String imagePath, Uint8List file) async {
    Reference ref = _storage.ref().child(imagePath);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
