  import 'package:equatable/equatable.dart';
  import '../entities/entities.dart';

  class MyUser extends Equatable {
    final String userId;
    final String email;
    final String name;
    final String bio;
    final List<Map<String, String>> reviews;
    

    const MyUser({required this.userId, required this.email, required this.name, required this.reviews, required this.bio});

    static const empty = MyUser(userId: '', email: '', name: '', reviews: [], bio: '' ,);

    MyUser copyWith({String? userId, String? email, String? name, List<Map<String, String>>? reviews, String? bio,}) {
      return MyUser(
          userId: userId ?? this.userId,
          email: email ?? this.email,
          name: name ?? this.name,
          reviews: reviews ?? this.reviews,
          bio: bio ?? this.bio,
          );
    }

    MyUserEntity toEntity() {
      return MyUserEntity(userId: userId, email: email, name: name, reviews: reviews, bio: bio,);
    }

    static MyUser fromEntity(MyUserEntity entity) {
      return MyUser(
          userId: entity.userId, email: entity.email, name: entity.name, reviews: entity.reviews, bio: entity.bio);
    }

    @override
    List<Object?> get props => [userId, email, name, reviews, bio];
  }
