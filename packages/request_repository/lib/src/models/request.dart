import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/entities.dart';

class Request {
  String id;
  String fromUserId;
  String productId;
  bool? accepted;
  Timestamp created_at;

  Request({
    required this.id,
    required this.fromUserId,
    required this.productId,
    required this.created_at,
    this.accepted,

  });

  RequestEntity toEntity() {
    return RequestEntity(
      id: id,
      fromUserId: fromUserId,
      productId: productId,
      accepted: accepted,
      created_at: created_at,
    );
  }

  static Request fromEntity(RequestEntity entity) {
    return Request(
      id: entity.id,
      fromUserId: entity.fromUserId,
      productId: entity.productId,
      accepted: entity.accepted,
      created_at: entity.created_at,

    );
  }
}
