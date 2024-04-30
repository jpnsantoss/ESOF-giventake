import 'dart:developer';

import 'package:review_repository/request_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseReviewRepo implements ReviewRepo {
  final reviewCollection = FirebaseFirestore.instance.collection('reviews');

  @override
  Future<void> addReview(Review review) async {
    try {
      await reviewCollection.add({
        'fromId': review.fromUserId,
        'toId': review.toUserId,
        'comment': review.comment,
        'rating': review.rating,
      });
    } catch (e) {
      print("Erro ao adicionar review: $e");
      rethrow;
    }
  }

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
}
