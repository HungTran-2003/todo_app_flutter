import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_app/database/app_share_preferences.dart';

class AppSecureStorage {
  // Private constructor
  final FlutterSecureStorage _storage;

  AppSecureStorage._(this._storage);

  static final AppSecureStorage _instance = AppSecureStorage._(
    const FlutterSecureStorage(),
  );

  static AppSecureStorage get instance => _instance;

  static const _refreshTokenKey = "refresh_token";

  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getRefreshToken() async {
    final isFirstRun = await AppSharePreferences.isFirstRun();
    log("isFirstRun: $isFirstRun");
    if (isFirstRun) {
      await deleteRefreshToken();
      return null;
    }
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> deleteRefreshToken() async {
    log("delete refresh token");
    await _storage.delete(key: _refreshTokenKey);
  }
}
