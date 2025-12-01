import 'package:flutter/material.dart';
import 'package:todo_app/common/app_navigator.dart';
import 'package:todo_app/router/router_config.dart';

class SignUpNavigator extends AppNavigator {
  SignUpNavigator({required super.context});

  @override
  Future<void> openSignIn() async {
    if (Navigator.canPop(context)) {
      pop();
    } else {
      await pushReplacementName(AppRouter.login);
    }
  }
}
