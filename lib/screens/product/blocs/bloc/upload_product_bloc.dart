import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

part 'upload_product_event.dart';
part 'upload_product_state.dart';

class UploadProductBloc extends Bloc<UploadProductEvent, UploadProductState> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UploadProductBloc() : super(UploadProductInitial()) {
    on<UploadNewProductEvent>((event, emit) async {
      emit(UploadProductProcess());
      try {
        String title = event.title;
        String location = event.location;
        String description = event.descrition;
        Uint8List? photo = event.photo;
        DateTime now = DateTime.now();
        bool sold = false;


        String resp = await saveProductToFirestore(
            title: title,
            location: location,
            description: description,
            createdAt: now,
            sold: sold,
            file: photo!);
        if (resp == 'sucess') {
          emit(UploadProductSuccess());
        }
      } catch (error) {
        emit(UploadProductFailure());
      }
    });
  }

  Future<String> saveProductToFirestore(
      {required String title,
      required String location,
      required String description,
      required DateTime createdAt,
      required bool sold,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      print(userId);

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
          'createdAt': createdAt,
          'sold': sold,
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
