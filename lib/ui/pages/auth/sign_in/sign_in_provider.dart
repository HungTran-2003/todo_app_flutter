import 'package:flutter/material.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/pages/auth/sign_in/sign_in_navigator.dart';

class SignInProvider extends ChangeNotifier {
  final SignInNavigator navigator;
  final AuthRepository authRepository;
  final TodoRepository todoRepository;

  SignInProvider({required this.navigator, required this.authRepository, required this.todoRepository});

  Future<void> signIn(String email, String password) async {
    navigator.showLoadingOverlay();
    try {
      final user = await authRepository.signInWithEmail(email, password);
      if (user == null) {
        navigator.showSnackBar("Login failed", Colors.red);
        navigator.hideLoadingOverlay();
        return;
      }
      final todos = await todoRepository.getTodos();
      navigator.showSnackBar("Login success", Colors.green);
      navigator.openHomePage(todos);
    } catch (e) {
      navigator.showSnackBar("System Error", Colors.red);
    }
    navigator.hideLoadingOverlay();
  }
}
