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

  UserInfoEntity? _userInfo;
  UserInfoEntity? get userInfo => _userInfo;

  Future<void> fetchUserInfo() async {
    _userInfo = await userRepository.getUserInfo();
    log(_userInfo!.toJson().toString());
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

      userInfo!.avatarPath =
          "$path?refresh=${DateTime.now().millisecondsSinceEpoch}";
      final updatedUserInfo = await userRepository.updateUserInfo(userInfo!);
      _userInfo = updatedUserInfo;
      notifyListeners();
      navigator.showSnackBar("Upload Image Success", Colors.green);
    } catch (e) {
      log(e.toString());
      navigator.showSnackBar("Error Upload Image", Colors.red);
    }
    navigator.hideLoadingOverlay();
  }

  Future<void> changeUserName(String userName) async {
    if (userInfo == null) return;
    navigator.showLoadingOverlay();
    userInfo!.userName = userName;
    try {
      final updatedUserInfo = await userRepository.updateUserInfo(userInfo!);
      _userInfo = updatedUserInfo;
      navigator.showSnackBar("Change Name Success", Colors.green);
      notifyListeners();
    } catch (e) {
      log(e.toString());
      navigator.showSnackBar("Error Change Name", Colors.red);
    }
    navigator.hideLoadingOverlay();
    notifyListeners();
  }
}
