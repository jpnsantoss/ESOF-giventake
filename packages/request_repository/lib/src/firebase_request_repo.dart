import 'dart:developer';

import 'package:request_repository/request_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRequestRepo implements RequestRepo {
  final requestCollection = FirebaseFirestore.instance.collection('requests');

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
}