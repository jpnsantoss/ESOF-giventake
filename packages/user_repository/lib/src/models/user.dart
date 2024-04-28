  import 'package:equatable/equatable.dart';
  import '../entities/entities.dart';

  class MyUser extends Equatable {
    final String userId;
    final String email;
    final String name;
    final String bio;
    final List<Map<String, String>> reviews;
    final double rating;
    

    const MyUser({required this.userId, required this.email, required this.name, required this.reviews, required this.bio, required this.rating,});

    static const empty = MyUser(userId: '', email: '', name: '', reviews: [], bio: '' , rating: 0.0,);

    MyUser copyWith({String? userId, String? email, String? name, List<Map<String, String>>? reviews, String? bio, double? rating}) {
      return MyUser(
          userId: userId ?? this.userId,
          email: email ?? this.email,
          name: name ?? this.name,
          reviews: reviews ?? this.reviews,
          bio: bio ?? this.bio,
          rating: rating ?? this.rating,
          );
    }

    MyUserEntity toEntity() {
      return MyUserEntity(userId: userId, email: email, name: name, reviews: reviews, bio: bio, rating: rating);
    }

    static MyUser fromEntity(MyUserEntity entity) {
      return MyUser(
          userId: entity.userId, email: entity.email, name: entity.name, reviews: entity.reviews, bio: entity.bio, rating: entity.rating,);
    }

    @override
    List<Object?> get props => [userId, email, name, reviews, bio, rating];
  }
