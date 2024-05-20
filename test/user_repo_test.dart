import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_repository/user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUser extends Mock implements User {}


void main() {
  setupFirebaseAuthMocks();


  group('FirebaseUserRepo', () {
    setUpAll(() async {
      // Initialize Firebase
      await Firebase.initializeApp();



    });

    test('should return a user', () async {

      final googleSignIn = MockGoogleSignIn();
      final signinAccount = await googleSignIn.signIn();
      final googleAuth = await signinAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final firestore = FakeFirebaseFirestore();

      final auth = MockFirebaseAuth();

      FirebaseUserRepo(
        firebaseAuth:auth,
      );

      final user = MockUser();

      // Create a user document in the fake Firestore
      firestore.collection('users').doc('userId').set({
        'userId': 'userId',
        'email': 'email@example.com',
        'name': 'Test User',
        'rating': 4.5,
        'bio': 'Bio',
        'image': 'http://image.url',
      });

      // Create a user object

      // Stub the currentUser property to return the user object
      when(auth.currentUser).thenReturn(user);

      // Create an instance of FirebaseUserRepo with the fake FirebaseAuth
      final repo = FirebaseUserRepo(firebaseAuth: auth);

      // Call the getUser method
      final result = await repo.getUser('userId');

      // Verify that the method returns the expected MyUser object
      expect(result, isA<MyUser>());
      expect(result.userId, 'userId');
      expect(result.email, 'email@example.com');
      expect(result.name, 'Test User');
      expect(result.rating, 4.5);
      expect(result.bio, 'Bio');
      expect(result.image, 'http://image.url');
    });
  });
}







