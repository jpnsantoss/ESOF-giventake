class RequestEntity {
  final String id;
  final String fromUserId;
  final String productId;
  bool accepted = false;
  //if accepted is to be changed by state is this correct?

  RequestEntity({
    required this.id,
    required this.fromUserId,
    required this.productId,
    bool accepted = false,
  }) : accepted = accepted;
  void acceptEntity(bool newValue) {
    accepted = true;
  }

  void undoAcceptEntity(bool newValue) {
    accepted = false;
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'productId': productId,
      'accepted': accepted
    };
  }

  static RequestEntity fromDocument(Map<String, dynamic> doc, String id){
    return RequestEntity(
      id: id,
      fromUserId: doc['fromUserId'] as String,
      productId: doc['productId'] as String,
      accepted: doc['accepted'] as bool,
    );
  }
}