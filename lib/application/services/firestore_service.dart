import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  // Create new user
  Future<void> addUser({required String userID}) async {
    await _users.doc(userID).set({
      'userID': userID,
    });
  }

  // Update user
  Future<void> updateUser({required String userID}) async {
    await _users.doc(userID).update({
      'userID': userID,
    });
  }

  // Delete user
  Future<void> deleteUser({required String userID}) async {
    await _users.doc(userID).delete();
  }

  // Get user
  Future<DocumentSnapshot> getUser({required String userID}) async {
    return await _users.doc(userID).get();
  }

  // Get all users
  Stream<QuerySnapshot> getUsers() {
    return _users.snapshots();
  }
}
