class ReviewEntity {
  String fromId;
  String toId;
  String comment;
  double rating;

  ReviewEntity({
    required this.fromId,
    required this.toId,
    required this.comment,
    required this.rating,
  });

  Map<String, Object?> toDocument() {
    return {
      'fromUserId': fromId,
      'toUserId': toId,
      'comment': comment,
      'rating': rating,
    };
  }

  static ReviewEntity fromDocument(Map<String, dynamic> doc) {
    return ReviewEntity(
      fromId: doc['fromId'] as String,
      toId: doc['toId'] as String,
      comment: doc['comment'] as String,
      rating: doc['rating'] as double,
    );
  }
}
