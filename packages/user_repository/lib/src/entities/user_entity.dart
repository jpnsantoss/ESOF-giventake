import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String bio;
  final num rating;
  final String image;


  const MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.bio,
    required this.rating,
    required this.image,
  });


  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
       'bio': bio,
      'rating': rating,
      'image': image,

    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'] ?? '',
      email: doc['email'] ?? '',
      name: doc['name'] ?? '',
      bio: doc['bio'] ?? '',
      rating: doc['rating'] ?? 0.0,
      image: doc['image'] ??
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png',
    );
  }

  @override
  List<Object?> get props => [userId, email, name, bio, rating, image];
}
