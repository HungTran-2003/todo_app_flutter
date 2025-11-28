class AppUtils {
  static String generateDeviceEmail(String deviceId) {
    final cleanId = deviceId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    return 'd$cleanId@gmail.com';
  }
}
