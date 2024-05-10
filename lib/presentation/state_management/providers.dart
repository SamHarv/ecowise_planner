// import flutter riverpod
import 'package:ecowise_planner/application/validation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/services/firebase_auth_service.dart';
import '../../application/services/firestore_service.dart';

// Firebase Auth Service
final firebaseAuth = StateProvider((ref) => FirebaseAuthService());

// Firestore Service
final firestore = StateProvider((ref) => FirestoreService());

final validation = StateProvider((ref) => Validation());
