import 'package:flutter_udid/flutter_udid.dart';

class DevicUntil {
  DevicUntil._();

  Future<String> getUDID() async {
    return await FlutterUdid.udid;
  }
}