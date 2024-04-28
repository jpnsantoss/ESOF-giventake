import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String userId;
  final String email;
  final String name;
  final List<Map<String, String>> reviews;
  final String bio;
  final double rating;

  const MyUserEntity(
      {required this.userId, required this.email, required this.name, required this.reviews, required this.bio, required this.rating,});

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'reviews': reviews,
      'bio' : bio,
      'rating' : rating, 
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    final List<Map<String, String>> reviewsList = (doc['reviews'] as List).map((review) {
      return Map<String, String>.from(review);
    }).toList();
    return MyUserEntity(
        userId: doc['userId'], email: doc['email'], name: doc['name'], reviews: reviewsList, bio: doc['bio'], rating: doc['rating'] ?? 0.0,);
  }

  @override
  List<Object?> get props => [userId, email, name, reviews, bio, rating];
}
