import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/models/entities/user_info_entity.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/repositories/notification_repository.dart';
import 'package:todo_app/repositories/user_repository.dart';
import 'package:todo_app/ui/pages/setting/setting_navigator.dart';

class SettingProvider extends ChangeNotifier {
  final SettingNavigator navigator;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final NotificationRepository notificationRepository;

  SettingProvider({
    required this.navigator,
    required this.authRepository,
    required this.notificationRepository,
    required this.userRepository,
  });

  UserInfoEntity? userInfo;

  Future<void> fetchUserInfo() async {
    userInfo = await userRepository.getUserInfo();
    log(userInfo!.toJson().toString());
    notifyListeners();
  }


  Future<void> logout() async {
    await authRepository.signOut();
    await notificationRepository.cancelAll();
    await navigator.openSignIn();
  }

  Future<void> showSimpleNotification() async {
    await notificationRepository.showNotification(
      id: 1,
      title: "test",
      body: "tesst",
    );
  }

  Future<void> changeImage(int choose) async {
    final picker = ImagePicker();
    XFile? pickedFile;
    if (choose == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile == null) return;
    final fileBytes = await pickedFile.readAsBytes();
    try {
      navigator.showLoadingOverlay();
      final path = await userRepository.uploadAvatar(fileBytes);

      userInfo!.avatarPath = "$path?refresh=${DateTime.now().millisecondsSinceEpoch}";
      final updatedUserInfo = await userRepository.updateUserInfo(userInfo!);
      userInfo = updatedUserInfo;
      notifyListeners();
      navigator.showSnackBar("Upload Image Success", Colors.green);
    } catch (e) {
      log(e.toString());
      navigator.showSnackBar("Error Upload Image", Colors.red);
    }
    navigator.hideLoadingOverlay();
  }

}
