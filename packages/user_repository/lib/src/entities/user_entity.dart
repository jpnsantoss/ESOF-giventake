import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String userId;
  final String email;
  final String name;
  final List<String> reviews;

  const MyUserEntity(
      {required this.userId, required this.email, required this.name, required this.reviews});

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'reviews': reviews,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
        userId: doc['userId'], email: doc['email'], name: doc['name'], reviews: (doc['reviews'] as List).cast<String>(),);
  }

  @override
  List<Object?> get props => [userId, email, name, reviews];
}
