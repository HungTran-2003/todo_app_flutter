import 'package:flutter/cupertino.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/repositories/notification_repository.dart';
import 'package:todo_app/ui/pages/setting/setting_navigator.dart';

class SettingProvider extends ChangeNotifier {
  final SettingNavigator navigator;
  final AuthRepository authRepository;
  final NotificationRepository notificationRepository;

  SettingProvider({required this.navigator, required this.authRepository, required this.notificationRepository});

  Future<void> logout() async {
    await authRepository.signOut();
    await notificationRepository.cancelAll();
    await navigator.openSignIn();
  }

  Future<void> showSimpleNotification() async {
    await notificationRepository.showNotification(id: 1, title: "test", body: "tesst");
  }
}
