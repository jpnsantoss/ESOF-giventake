import 'package:flutter_test/flutter_test.dart';
import 'package:user_repository/user_repository.dart';
import 'package:mockito/mockito.dart';


class MockFirebaseUserRepo extends Mock implements FirebaseUserRepo {
  @override
  Future<MyUser> getUser(String userId) async {
    return MyUser(
      userId: 'userId',
      email: 'email@example.com',
      name: 'Test User',
      rating: 4.5,
      bio: 'Bio',
      image: 'http://image.url',
    );
  }
}

void main() {
  group('FirebaseUserRepo', () {
    test('should return user id', () async {
      final mockFirebaseUserRepo = MockFirebaseUserRepo();

      final result = await mockFirebaseUserRepo.getUser('userId');

      expect(result, isA<MyUser>());
      expect(result.userId, 'userId');
    });

    test('should return user email', () async {
      final mockFirebaseUserRepo = MockFirebaseUserRepo();

      final result = await mockFirebaseUserRepo.getUser('email');

      expect(result, isA<MyUser>());
      expect(result.email, 'email@example.com');
    });

    test('should return user name', () async {
      final mockFirebaseUserRepo = MockFirebaseUserRepo();

      final result = await mockFirebaseUserRepo.getUser('name');

      expect(result, isA<MyUser>());
      expect(result.name, 'Test User');
    });

    test('should return user rating', () async {
      final mockFirebaseUserRepo = MockFirebaseUserRepo();

      final result = await mockFirebaseUserRepo.getUser('rating');

      expect(result, isA<MyUser>());
      expect(result.rating, 4.5);
    });

    test('should return user bio', () async {
      final mockFirebaseUserRepo = MockFirebaseUserRepo();

      final result = await mockFirebaseUserRepo.getUser('bio');

      expect(result, isA<MyUser>());
      expect(result.bio, 'Bio');
    });

    test('should return user image', () async {
      final mockFirebaseUserRepo = MockFirebaseUserRepo();

      final result = await mockFirebaseUserRepo.getUser('image');

      expect(result, isA<MyUser>());
      expect(result.image, 'http://image.url');
    });

  });
}




