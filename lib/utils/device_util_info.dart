import 'package:flutter_udid/flutter_udid.dart';

class DeviceUntil {
  DeviceUntil._();

  static Future<String> getUDID() async {
    return await FlutterUdid.udid;
  }
}