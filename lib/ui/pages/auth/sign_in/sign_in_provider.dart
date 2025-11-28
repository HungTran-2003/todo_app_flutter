import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/ui/pages/auth/sign_in/sign_in_navigator.dart';

class SignInProvider extends ChangeNotifier {
  final SignInNavigator navigator;

  SignInProvider({required this.navigator});

  Future<void> signIn(String email, String password) async {
    navigator.showLoadingOverlay();
    try {
      final user = await AuthService.instance.signInWithEmail(email, password);
      if (user == null) {
        navigator.showSnackBar("Login failed", Colors.red);
        navigator.hideLoadingOverlay();
        return;
      }
      final todos = await TodoService.instance.getTodos();
      navigator.showSnackBar("Login success", Colors.green);
      navigator.openHomePage(todos);
    } catch (e) {
      navigator.showSnackBar("System Error", Colors.red);
    }
    navigator.hideLoadingOverlay();
  }
}
