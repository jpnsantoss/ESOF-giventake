import 'package:user_repository/user_repository.dart';

import '../entities/entities.dart';

class Review {
  String fromUserId;
  String toUserId;
  String comment;
  double rating;

  MyUser? fromUser;

  Review({
    required this.fromUserId,
    required this.toUserId,
    required this.comment,
    required this.rating,
  });

  ReviewEntity toEntity() {
    return ReviewEntity(
      fromId: fromUserId,
      toId: toUserId,
      comment: comment,
      rating: rating,
    );
  }

  static Review fromEntity(ReviewEntity entity) {
    return Review(
      fromUserId: entity.fromId,
      toUserId: entity.toId,
      comment: entity.comment,
      rating: entity.rating,
    );
  }

  Future<void> fetchUser(UserRepository userRepository) async {
    fromUser = await userRepository.getUser(fromUserId);
  }
}
