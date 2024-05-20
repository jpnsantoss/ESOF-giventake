import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:request_repository/request_repository.dart';

class FirebaseRequestRepo implements RequestRepo {

  final requestQuery = FirebaseFirestore.instance.collection('requests').orderBy('created_at', descending: true);
  @override
  Future<List<Request>> getRequests() async {
    try {
          return await requestQuery.get().then((value) => value.docs
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
      await FirebaseFirestore.instance.collection('requests').add({
        'id': request.id,
        'fromUserId': request.fromUserId,
        'productId': request.productId,
        'accepted': request.accepted,
        'created_at': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
        print("Erro ao adicionar request: $e");
      rethrow;
    }
  }

    Future<void> acceptRequest(String requestId) async {
          try {
            await FirebaseFirestore.instance.collection('requests')
                .where('id', isEqualTo: requestId)
                .get()
                .then((querySnapshot) async {
              if (querySnapshot.docs.isNotEmpty) {
                DocumentReference docRef = querySnapshot.docs.first.reference;
        
                String productId = querySnapshot.docs.first.data()['product_id'];
        
                await docRef.update({'accepted': true});
        
                await FirebaseFirestore.instance.collection('requests')
                    .where('product_id', isEqualTo: productId)
                    .get()
                    .then((snapshot) {
                  for (var doc in snapshot.docs) {
                    if (doc.data()['accepted'] == null) {
                      doc.reference.update({'accepted': false});
                    }
                  }
                });
        
                await FirebaseFirestore.instance.collection('products')
                    .doc(productId)
                    .update({'sold': true});
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
      await FirebaseFirestore.instance.collection('requests')
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
