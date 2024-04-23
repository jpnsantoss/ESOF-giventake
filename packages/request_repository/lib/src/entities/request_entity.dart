class RequestEntity {
  final String id;
  final String fromUserId;
  final String productId;
  final String requesterId;
  bool accepted = false;

  RequestEntity({
    this.id = '',
    required this.fromUserId,
    required this.productId,
    required this.requesterId,
    this.accepted = false,
  });

  void acceptEntity(bool newValue) {
    accepted = true;
  }

  void undoAcceptEntity(bool newValue) {
    accepted = false;
  }

  Map<String, Object?> toDocument() {
    return {
      'fromUserId': fromUserId,
      'productId': productId,
      'requesterId': requesterId,
      'accepted': accepted,
    };
  }

  static RequestEntity fromDocument(Map<String, dynamic> doc, String id) {
    return RequestEntity(
      id: id,
      requesterId: doc['requesterId'] as String,
      fromUserId: doc['fromUserId'] as String,
      productId: doc['productId'] as String,
      accepted: doc['accepted'] as bool,
    );
  }
}
