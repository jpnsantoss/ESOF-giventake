import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:request_repository/request_repository.dart';

class FirebaseRequestRepo implements RequestRepo {
  final requestCollection = FirebaseFirestore.instance.collection('requests');

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

  @override
  Future<void> addRequest(Request request) async {
    try {
      await requestCollection.add({
        'id': request.id,
        'fromUserId': request.fromUserId,
        'productId': request.productId,
        'accepted': request.accepted,
      });
    } catch (e) {
        print("Erro ao adicionar request: $e");
      rethrow;
    }
  }

  @override
  Future<void> acceptRequest(String requestId) async {
    try {
      await requestCollection
          .where('id', isEqualTo: requestId)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference docRef = querySnapshot.docs.first.reference;

          return docRef.update({'accepted': true});
        } else {
          print("No document found with ID $requestId");
          throw Exception("No document found with ID $requestId");
        }
      });
    } catch (e) {
      throw Exception('Failed to accept request: $e');
    }
  }

  @override
  Future<void> rejectRequest(String requestId) async {
    try {
      await requestCollection
          .where('id', isEqualTo: requestId)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference docRef = querySnapshot.docs.first.reference;
          return docRef.update({'accepted': false});
        } else {
          print("No document found with ID $requestId");
          throw Exception("No document found with ID $requestId");
        }
      });
    }  catch (e) {
      throw Exception('Failed to reject request: $e');
    }
  }
}
