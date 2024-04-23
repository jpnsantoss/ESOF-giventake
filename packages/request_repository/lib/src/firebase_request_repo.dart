import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:request_repository/src/entities/request_entity.dart';
import 'package:request_repository/src/models/request.dart';
import 'package:request_repository/src/request_repo.dart';

class FirebaseRequestRepo implements RequestRepo {

  final requestCollection = FirebaseFirestore.instance.collection('requests');

  @override
  Future<void> addRequest(Request request) async {
    try {
      await requestCollection.add({
        'fromUserId': request.fromUserId,
        'productId': request.productId,
      });
    } catch (e) {
      print('Error adding request: $e');
      rethrow;
    }
  }
  @override
  Future<List<Request>> getRequests() async {
    try {
      final querySnapshot = await requestCollection.get();
      return querySnapshot.docs.map((doc) {
        final requestData = doc.data();
        final requestId = doc.id;
        return Request.fromEntity(RequestEntity.fromDocument(requestData, requestId));
      }).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}