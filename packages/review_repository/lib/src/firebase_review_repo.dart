import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:review_repository/request_repository.dart';

class FirebaseReviewRepo implements ReviewRepo {
  final reviewCollection = FirebaseFirestore.instance.collection('reviews');

  @override
  Future<List<Review>> getReviews(String userId) {
    return reviewCollection
        .where('toId', isEqualTo: userId)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        return Review(
          id: doc.id,
          fromUserId: doc['fromId'],
          toUserId: doc['toId'],
          comment: doc['comment'],
          rating: doc['rating'],
        );
      }).toList();
    });
  }

  @override
  @override
  Future<void> addReview(
      String fromUserId, String toUserId, String review, double rating) {
    return reviewCollection.add({
      'from_id': fromUserId,
      'to_id': toUserId,
      'description': review,
      'rating': rating,
    });
  }
}
