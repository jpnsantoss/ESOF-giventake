import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:request_repository/src/entities/request_entity.dart';
import 'package:request_repository/src/models/request.dart';
import 'package:request_repository/src/request_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRequestRepo implements RequestRepo {

  final requestCollection = FirebaseFirestore.instance.collection('requests');

  @override
  Future<void> addRequest(Request request) async {
    try {
      await requestCollection.add({
        'fromUserId': request.fromUserId,
        'productId': request.productId,
        'requesterId': request.requesterId,
      });
    } catch (e) {
      print('Error adding request: $e');
      rethrow;
    }
  }
  @override
  Future<List<Request>> getRequests() async {
    try {
      return await requestCollection.get().then((value) => value.docs
          .map((e) => Request.fromEntity(RequestEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}