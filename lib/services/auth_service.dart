import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/database/app_secure_storage.dart';
import 'package:todo_app/database/app_share_preferences.dart';

class AuthService {
  AuthService._();
  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;

  final _supabase = Supabase.instance.client;

  Future<User?> signUp(String email, String password, String udid) async {
    final authRes = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {"device_id": udid},
    );
    return authRes.user;
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final authRes = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      await AppSecureStorage.instance.saveRefreshToken(
        authRes.session!.refreshToken!,
      );
      return authRes.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signInWithToken(String token) async {
    try {
      final authRes = await _supabase.auth.refreshSession(token);
      await AppSecureStorage.instance.saveRefreshToken(
        authRes.session!.refreshToken!,
      );
      return authRes.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      await AppSecureStorage.instance.deleteRefreshToken();
      await AppSharePreferences.setFirstLogin();
    } catch (e) {
      log('Error during sign out: $e');
    }
  }
}
