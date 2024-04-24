import '../entities/entities.dart';

class Request {
  String id;
  String fromUserId;
  String productId;
  bool accepted;

  Request({
    required this.id,
    required this.fromUserId,
    required this.productId,
    required this.accepted,
  });

  RequestEntity toEntity() {
    return RequestEntity(
      id: id,
      fromUserId: fromUserId,
      productId: productId,
      accepted: accepted,
    );
  }

  static Request fromEntity(RequestEntity entity) {
    return Request(
      id: entity.id,
      fromUserId: entity.fromUserId,
      productId: entity.productId,
      accepted: entity.accepted,
    );
  }
}