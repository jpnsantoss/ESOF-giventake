import 'package:flutter_test/flutter_test.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('MyUser model', () {
    test('copyWith() should return a new instance with updated values', () {
      // Create a sample MyUser instance
      final myUser = MyUser(
        userId: 'user123',
        email: 'test@example.com',
        name: 'Test User',
        bio: 'Test bio',
        rating: 4.5,
        image: 'https://example.com/image.png',
      );

      // Update some fields using copyWith()
      final updatedUser = myUser.copyWith(
        email: 'updated@example.com',
        bio: 'Updated bio',
        rating: 4.7,
      );

      // Verify that the updated fields have changed
      expect(updatedUser.userId, myUser.userId); // userId should remain the same
      expect(updatedUser.email, 'updated@example.com');
      expect(updatedUser.name, myUser.name); // name should remain the same
      expect(updatedUser.bio, 'Updated bio');
      expect(updatedUser.rating, 4.7);
      expect(updatedUser.image, myUser.image); // image should remain the same
    });

    test('fromEntity() should convert a MyUserEntity to MyUser', () {
      // Create a sample MyUserEntity instance
      final entity = MyUserEntity(
        userId: 'user123',
        email: 'test@example.com',
        name: 'Test User',
        bio: 'Test bio',
        rating: 4.5,
        image: 'https://example.com/image.png',
      );

      // Convert the MyUserEntity to MyUser using fromEntity()
      final myUser = MyUser.fromEntity(entity);

      // Verify that the MyUser object has the correct values
      expect(myUser.userId, entity.userId);
      expect(myUser.email, entity.email);
      expect(myUser.name, entity.name);
      expect(myUser.bio, entity.bio);
      expect(myUser.rating, entity.rating);
      expect(myUser.image, entity.image);
    });

    test('props should return the correct list of properties', () {
      // Create a sample MyUser instance
      final myUser = MyUser(
        userId: 'user123',
        email: 'test@example.com',
        name: 'Test User',
        bio: 'Test bio',
        rating: 4.5,
        image: 'https://example.com/image.png',
      );

      // Verify that props returns the correct list of properties
      expect(myUser.props, [
        myUser.userId,
        myUser.email,
        myUser.name,
        myUser.bio,
        myUser.rating,
        myUser.image,
      ]);
    });

    test('empty should return an instance with empty values', () {
      // Get the empty instance of MyUser
      final emptyUser = MyUser.empty;

      // Verify that all fields are empty or zero
      expect(emptyUser.userId, '');
      expect(emptyUser.email, '');
      expect(emptyUser.name, '');
      expect(emptyUser.bio, '');
      expect(emptyUser.rating, 0.0);
      expect(emptyUser.image, 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png');
    });
  });
}
