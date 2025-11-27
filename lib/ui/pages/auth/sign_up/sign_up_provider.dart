import 'package:flutter/cupertino.dart';
import 'package:todo_app/ui/pages/auth/sign_up/sign_up_navigator.dart';

class SignUpProvider extends ChangeNotifier{
  final SignUpNavigator navigator;

  SignUpProvider({required this.navigator});
}