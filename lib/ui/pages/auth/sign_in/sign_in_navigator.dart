import 'package:todo_app/common/app_navigator.dart';
import 'package:todo_app/router/router_config.dart';

class SignUpNavigator extends AppNavigator {
  SignUpNavigator({required super.context});

  Future<void> openSignUp() async{
    await pushName(AppRouter.register);
  }
}