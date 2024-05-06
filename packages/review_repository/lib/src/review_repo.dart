import 'models/models.dart';

abstract class ReviewRepo {
  Future<List<Review>> getReviews(String userId);
  Future<void> addReview(Review review);
}
