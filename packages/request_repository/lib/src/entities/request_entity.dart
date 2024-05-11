class RequestEntity {
  String id;
  String fromUserId;
  String productId;
  bool accepted;

  RequestEntity({
    required this.id,
    required this.fromUserId,
    required this.productId,
    required this.accepted,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'productId': productId,
      'accepted': accepted,
    };
  }

  static RequestEntity fromDocument(Map<String, dynamic> doc) {
    return RequestEntity(
      id: doc['id'],
      fromUserId: doc['fromUserId'],
      productId: doc['productId'],
      accepted: doc['accepted'] ?? false,
    );
  }


}
