import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steps_counter/domain/auth_service/auth_service.dart';
import 'package:steps_counter/domain/background_service/background_service.dart';
import 'package:steps_counter/domain/firebase_service/auth_state_enums.dart';

class AuthServiceNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthServiceNotifier(this._authService) : super(AuthState.unauthenticated);

  Future<User?> signInAnonymously({
    required String username,
    required double weight,
  }) async {
    state = AuthState.loading;
    try {
      final user = await _authService.signInAnonymously(
        username: username,
        weight: weight,
      );

      if (user != null) {
        state = AuthState.authenticated;
        return user;
      } else {
        state = AuthState.unauthenticated;
        return null;
      }
    } catch (e) {
      state = AuthState.error;
      debugPrint("Error during sign-in: $e");
      return null;
    } finally {
      if (state == AuthState.loading) {
        state = AuthState.unauthenticated;
      }
    }
  }

  Future<void> signOut() async {
    state = AuthState.loading;
    try {
      await _authService.signOut();
      state = AuthState.unauthenticated;
      // To stop the service
      StepsBackgroundService.stopBackgroundService();
    } catch (e) {
      state = AuthState.error;
      debugPrint("Error signing out: $e");
    }
  }

  Future<AuthState> checkAuthStatus() async {
    state = AuthState.loading;
    try {
      final isAuthenticated = await _authService.checkAuthStatus();
      return state =
          isAuthenticated ? AuthState.authenticated : AuthState.unauthenticated;
    } catch (e) {
      debugPrint("Error checking auth status: $e");
      return state = AuthState.error;
    }
  }
}
