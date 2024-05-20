import 'package:cloud_firestore/cloud_firestore.dart';
class RequestEntity {
  String id;
  String fromUserId;
  String productId;
  bool? accepted;
  Timestamp created_at;

  RequestEntity({
    required this.id,
    required this.fromUserId,
    required this.productId,
    required this.created_at,
    this.accepted
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'productId': productId,
      'accepted': accepted,
      'created_at': created_at,
    };
  }

  static RequestEntity fromDocument(Map<String, dynamic> doc) {
    return RequestEntity(
      id: doc['id'],
      fromUserId: doc['fromUserId'],
      productId: doc['productId'],
      accepted: doc['accepted'],
      created_at: doc['created_at'],
    );
  }


}
