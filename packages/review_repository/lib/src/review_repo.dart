import 'models/models.dart';

abstract class ReviewRepo {
  Future<List<Review>> getReviews(String userId);
  Future<int> getReviewCount(String userId);
  Future<void> addReview(
      String fromUserId, String toUserId, String comment, double rating);
}
