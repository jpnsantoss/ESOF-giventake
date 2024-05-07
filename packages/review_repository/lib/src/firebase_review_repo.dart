import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:review_repository/review_repository.dart';

class FirebaseReviewRepo implements ReviewRepo {
  final reviewCollection = FirebaseFirestore.instance.collection('reviews');

  @override
  Future<List<Review>> getReviews(String userId) async {
    try {
      return await reviewCollection.where('toId', isEqualTo: userId).get().then(
          (value) => value.docs
              .map(
                  (e) => Review.fromEntity(ReviewEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addReview(
      String fromUserId, String toUserId, String comment, double rating) async {
    try {
      await reviewCollection.add({
        'fromId': fromUserId,
        'toId': toUserId,
        'comment': comment,
        'rating': rating,
      });
    } catch (e) {
      rethrow;
    }
  }
}
