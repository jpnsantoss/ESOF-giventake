import 'package:flutter_test/flutter_test.dart';
import 'package:user_repository/user_repository.dart'; // Import your FirebaseUserRepo class
import 'package:mocktail/mocktail.dart';
// Mock class for FirebaseUserRepo
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

      // Specify the exact argument expected
      when(mockFirebaseUserRepo.getUser('userId') as Function()).thenAnswer((_) async => mockUser);

      final result = await mockFirebaseUserRepo.getUser('userId');

      expect(result, isA<MyUser>());
      expect(result.name, 'Test User');
    });
  });
}
