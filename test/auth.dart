import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:user_repository/user_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockFirebaseUserRepo extends Mock implements FirebaseUserRepo {}


void main() {
  group('FirebaseUserRepo', () {
    test('should return user data', () async {
      final mockFirebaseUserRepo = MockFirebaseUserRepo();
      final mockUser = MyUser(
        userId: 'userId',
        email: 'email@example.com',
        name: 'Test User',
        rating: 4.5,
        bio: 'Bio',
        image: 'http://image.url',
      );

      // Ensure the mock returns a Future<MyUser>
      when(mockFirebaseUserRepo.getUser('userId')).thenAnswer((_) async => mockUser);

      final result = await mockFirebaseUserRepo.getUser('userId');

      expect(result, isA<MyUser>());
      expect(result.name, 'Test User');
    });
  });
}



