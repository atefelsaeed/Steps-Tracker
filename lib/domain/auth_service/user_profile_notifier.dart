import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/data/data_source/auth_data_source.dart';
import 'package:steps_counter/data/models/user_model.dart';

import 'auth_service.dart';

class UserProfileNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final AuthLocalDataSource _localDataSource = AuthLocalDataSource();

  UserProfileNotifier() : super(const AsyncValue.loading()) {
    _loadCurrentUserProfile();
  }

  Future<void> _loadCurrentUserProfile() async {
    try {
      // // Load from local storage first
      // final localData = await _localDataSource.currentUser();
      // if (localData != null) {
      //   state = AsyncValue.data(localData);
      // } else {
        // If not available locally, fetch from Firestore
        final user = AuthService().getCurrentUser();
        if (user != null) {
          final userDoc =
              await _firestore.collection('users').doc(user.uid).get();
          final userMap = userDoc.data();
          if (userMap != null) {
            final userModel = UserModel.fromMap(userMap, user.uid);
            state = AsyncValue.data(userModel);
            _localDataSource.persistAuth(userModel); // Save data locally
          } else {
            state = AsyncValue.error("User data not found", StackTrace.current);
          }
        } else {
          state = const AsyncValue.data(null);
        }
      // }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> updateWeight(double newWeight) async {
    if (state.value != null) {
      try {
        final updatedUser = state.value!.copyWith(weight: newWeight);
        await _firestore.collection('users').doc(updatedUser.uid).update({
          'weight': newWeight,
        });
        _localDataSource.persistAuth(updatedUser); // Update local data
        state = AsyncValue.data(updatedUser); // Update provider state
      } catch (e, s) {
        state = AsyncValue.error(e, s);
      }
    }
  }

  Future<void> updateProfileImage(File imageFile, String uid) async {
    if (state.value != null) {
      try {
        final storageRef =
            _firebaseStorage.ref().child('profile_images/$uid.jpg');
        await storageRef.putFile(imageFile);
        final imageUrl = await storageRef.getDownloadURL();

        final updatedUser = state.value!.copyWith(profileImage: imageUrl);
        await _firestore.collection('users').doc(updatedUser.uid).update({
          'profileImage': imageUrl,
        });

        _localDataSource.persistAuth(updatedUser); // Update local data
        state = AsyncValue.data(updatedUser); // Update provider state
      } catch (e, s) {
        state = AsyncValue.error(e, s);
      }
    }
  }
}

// Define the provider with the new state management.
final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, AsyncValue<UserModel?>>((ref) {
  return UserProfileNotifier();
});
