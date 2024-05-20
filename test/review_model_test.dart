import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:review_repository/review_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('Review model', () {
    test('toEntity() should return a ReviewEntity with correct values', () {
      // Create a sample review
      final review = Review(
        fromUserId: 'fromUserId',
        toUserId: 'toUserId',
        comment: 'Great product!',
        rating: 4.5,
      );

      final reviewEntity = review.toEntity();

      expect(reviewEntity.fromId, review.fromUserId);
      expect(reviewEntity.toId, review.toUserId);
      expect(reviewEntity.comment, review.comment);
      expect(reviewEntity.rating, review.rating);
    });

    test('fromEntity() should return a Review with correct values', () {
      final reviewEntity = ReviewEntity(
        fromId: 'fromUserId',
        toId: 'toUserId',
        comment: 'Great product!',
        rating: 4.5,
      );

      final review = Review.fromEntity(reviewEntity);

      expect(review.fromUserId, reviewEntity.fromId);
      expect(review.toUserId, reviewEntity.toId);
      expect(review.comment, reviewEntity.comment);
      expect(review.rating, reviewEntity.rating);
    });

  });
}

class MockUserRepository extends Mock implements UserRepository {}
