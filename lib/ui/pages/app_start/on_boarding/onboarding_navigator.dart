import 'dart:developer';

import 'package:todo_app/common/app_navigator.dart';
import 'package:todo_app/router/router_config.dart';

class OnboardingNavigator extends AppNavigator {
  OnboardingNavigator({required super.context});

  Future<void> openHomePage() async {
    pushReplacementName(AppRouter.home);
  }

  Future<void> openLoginPage() async {
    log("login");
  }

  Future<void> openSignUpPage() async {
    log("signup");
  }
}
