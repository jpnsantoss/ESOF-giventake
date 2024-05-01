import 'dart:developer';
import 'package:request_repository/request_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseRequestRepo implements RequestRepo {
  final requestCollection = FirebaseFirestore.instance.collection('requests');

  @override
  Future<List<Request>> getRequests() async {
    try {
      return await requestCollection
          .get()
          .then((value) => value.docs.map((e) =>
          Request.fromEntity(RequestEntity.fromDocument(e.data()))).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addRequest(Request request) async {
    try {
      await requestCollection.add( {
        'id': request.id,
        'fromUserId': request.fromUserId,
        'productId': request.productId,
        'accepted': request.accepted,
      });
    }
    catch (e) {
      print("Erro ao adicionar request: $e");
      rethrow;
    }
  }

  @override
  Future<void> acceptRequest(String requestId) async {
    try {
      await requestCollection.doc(requestId).update({
        'accepted': true,
      });
    } catch (e) {
      throw 'Failed to accept request: $e';
    }
  }

  @override
  Future<void> rejectRequest(String requestId) async {
    try {
      await requestCollection.doc(requestId).delete();
    } catch (e) {
      throw Exception('Failed to reject request: $e');
    }
  }


}