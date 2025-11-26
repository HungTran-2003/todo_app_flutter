import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/utils/device_util_info.dart';

class AuthService {

  final _supabase = Supabase.instance.client;

   Future<User?> signInWithDeviceId() async{
    final udid = await DeviceUntil.getUDID();
    final email = _generateDeviceEmail(udid);
    final password = "$udid";
    try {
      final authRes = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {"device_id": udid},
      );
      return authRes.user;
    } catch (e) {
      log(e.toString());
      final authRes = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return authRes.user;
    }
  }

  String _generateDeviceEmail(String deviceId) {
    final cleanId = deviceId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    return 'd$cleanId@gmail.com';
  }
}