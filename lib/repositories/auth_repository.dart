import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/database/app_secure_storage.dart';
import 'package:todo_app/database/app_share_preferences.dart';
import 'package:todo_app/networking/api_client.dart';

abstract class AuthRepository {
  Future<User?> signUp(String email, String password, String udid);

  Future<User?> signInWithEmail(String email, String password);

  Future<User?> signInWithToken(String token);

  Future<void> signOut();
}

class AuthRepositoryImpl extends AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl(this._apiClient);

  @override
  Future<User?> signUp(String email, String password, String udid) async {
    try {
      final response = await _apiClient.signUp(
        email: email,
        password: password,
        udid: udid,
      );
      return response.user;
    } catch (e) {
      log('Error during sign up: $e');
      rethrow;
    }
  }

  @override
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final authRes = await _apiClient.signInWithEmail(
        email: email,
        password: password,
      );

      if (authRes.session?.refreshToken != null) {
        await AppSecureStorage.instance.saveRefreshToken(
          authRes.session!.refreshToken!,
        );
      }

      return authRes.user;
    } catch (e) {
      log('Error during sign in: $e');
      return null;
    }
  }

  @override
  Future<User?> signInWithToken(String token) async {
    try {
      final authRes = await _apiClient.refreshSession(token);
      if (authRes.session?.refreshToken != null) {
        await AppSecureStorage.instance.saveRefreshToken(
          authRes.session!.refreshToken!,
        );
      }
      return authRes.user;
    } catch (e) {
      log('Error during token refresh: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _apiClient.signOut();

      await AppSecureStorage.instance.deleteRefreshToken();
      await AppSharePreferences.setFirstLogin();
    } catch (e) {
      log('Error during sign out: $e');
    }
  }
}
