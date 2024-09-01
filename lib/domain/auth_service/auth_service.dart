import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/core/utils/key_constant.dart';
import 'package:steps_counter/data/data_source/auth_data_source.dart';
import 'package:steps_counter/data/data_source/data_storage.dart';
import 'package:steps_counter/data/models/user_model.dart';
import 'package:steps_counter/domain/auth_service/auth_service_notifier.dart';
import 'package:steps_counter/domain/firebase_service/auth_state_enums.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthLocalDataSource dataSource = AuthLocalDataSource();

  Future<User?> signInAnonymously({
    required String username,
    required double weight,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        debugPrint("userData");
        final userData = UserModel(
          uid: user.uid,
          name: username,
          weight: weight,
          createdAt: DateTime.now(),
          totalSteps: 0,
        );

        await _firestore.collection('users').doc(user.uid).set(
              userData.toMap(forFirestore: true),
            );
        await dataSource.persistAuth(userData);
      }

      return user;
    } catch (e) {
      debugPrint("Error in anonymous sign-in: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await dataSource.clearAuth();
    } catch (e) {
      debugPrint("Error signing out: $e");
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<Map<String, dynamic>?> getUserData() async {
    User? user = getCurrentUser();
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      return userDoc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  Future<bool> checkAuthStatus() async {
    final userData = await DataStorage.readData(KeyConstants.currentUser);
    return userData != null;
  }
}

// Define the provider with the new state management.
final authServiceProvider =
    StateNotifierProvider<AuthServiceNotifier, AuthState>((ref) {
  final authService = AuthService();
  return AuthServiceNotifier(authService);
});
