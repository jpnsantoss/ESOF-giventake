import 'dart:developer';

import 'package:request_repository/request_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}