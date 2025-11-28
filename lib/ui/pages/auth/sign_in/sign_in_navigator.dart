import 'package:todo_app/common/app_navigator.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/router/router_config.dart';

class SignInNavigator extends AppNavigator {
  SignInNavigator({required super.context});

  Future<void> openSignUp() async {
    await pushName(AppRouter.register);
  }

  Future<void> openHomePage(List<TodoEntity> todos) async {
    await pushReplacementName(AppRouter.home, arguments: todos);
  }
}
