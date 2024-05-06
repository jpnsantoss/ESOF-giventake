import '../entities/entities.dart';

class Review {
  String id;
  String fromUserId;
  String toUserId;
  String comment;
  int rating;

  Review({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.comment,
    required this.rating,
  });

  ReviewEntity toEntity() {
    return ReviewEntity(
      id: id,
      fromUserId: fromUserId,
      toUserId: toUserId,
      comment: comment,
      rating: rating,
    );
  }

  static Review fromEntity(ReviewEntity entity) {
    return Review(
      id: entity.id,
      fromUserId: entity.fromUserId,
      toUserId: entity.toUserId,
      comment: entity.comment,
      rating: entity.rating,
    );
  }
}
