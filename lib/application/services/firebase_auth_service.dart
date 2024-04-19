import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // get user
  User? get user => _firebaseAuth.currentUser;

  // Sign up
  Future<User?> signUp(
      {required String email,
      required String password,
      required FirestoreService db}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await db.addUser(userID: userCredential.user!.uid);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in
  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Delete account
  Future<void> deleteAccount() async {
    await _firebaseAuth.currentUser?.delete();
  }

  // reset password
  Future<void> resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
