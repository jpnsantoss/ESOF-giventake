import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:review_repository/review_repository.dart'; // Import ReviewRepo
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final reviewsCollection = FirebaseFirestore.instance.collection('reviews');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final FirebaseAuth auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      String userId = user!.uid;
      await FirebaseUserRepo().getUser(userId);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'email': user.email});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser = myUser.copyWith(userId: user.user!.uid);

      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<MyUser> getUser(String userId) async {
    try {
      MyUser user = await usersCollection.doc(userId).get().then((value) =>
          MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));

      // Fetch reviews for the user directly from the reviews collection
      QuerySnapshot reviewsSnapshot =
          await reviewsCollection.where('toId', isEqualTo: userId).get();

      List<Review> reviews = reviewsSnapshot.docs.map((doc) {
        return Review(
          fromUserId: doc['fromId'],
          toUserId: doc['toId'],
          comment: doc['comment'],
          rating: doc['rating'],
        );
      }).toList();

      // Calculate average rating
      double averageRating = 0.0;
      if (reviews.isNotEmpty) {
        double totalRating = reviews.fold(
            0, (previousValue, element) => previousValue + element.rating);
        averageRating = totalRating / reviews.length;
      }

      await usersCollection.doc(userId).update({'rating': averageRating});

      // Update user rating
      user = user.copyWith(rating: averageRating);

      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
