class ReviewEntity {
  String id;
  String fromUserId;
  String toUserId;
  String comment;
  double rating;

  ReviewEntity({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.comment,
    required this.rating,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'comment': comment,
      'rating': rating,
    };
  }

  static ReviewEntity fromDocument(Map<String, dynamic> doc) {
    return ReviewEntity(
      id: doc['id'] as String,
      fromUserId: doc['fromUserId'] as String,
      toUserId: doc['toUserId'] as String,
      comment: doc['comment'] as String,
      rating: doc['rating'] as double,
    );
  }
}
