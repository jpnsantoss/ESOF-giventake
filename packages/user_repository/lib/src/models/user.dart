  import 'package:equatable/equatable.dart';
  import '../entities/entities.dart';

  class MyUser extends Equatable {
    final String userId;
    final String email;
    final String name;
    final String bio;
    final List<Map<String, String>> reviews;
    final num rating;
    final String image;
    

    const MyUser({required this.userId, required this.email, required this.name, required this.reviews, required this.bio, required this.rating, required this.image,});

    static const empty = MyUser(userId: '', email: '', name: '', reviews: [], bio: '' , rating: 0.0, image:'' );

    MyUser copyWith({String? userId, String? email, String? name, List<Map<String, String>>? reviews, String? bio, num? rating, String? image}) {
      return MyUser(
          userId: userId ?? this.userId,
          email: email ?? this.email,
          name: name ?? this.name,
          reviews: reviews ?? this.reviews,
          bio: bio ?? this.bio,
          rating: rating ?? this.rating,
          image: image ?? this.image,
          );
    }

    MyUserEntity toEntity() {
      return MyUserEntity(userId: userId, email: email, name: name, reviews: reviews, bio: bio, rating: rating, image: image,);
    }

    static MyUser fromEntity(MyUserEntity entity) {
      return MyUser(
          userId: entity.userId, email: entity.email, name: entity.name, reviews: entity.reviews, bio: entity.bio, rating: entity.rating, image: entity.image);
    }

    @override
    List<Object?> get props => [userId, email, name, reviews, bio, rating, image];
  }
