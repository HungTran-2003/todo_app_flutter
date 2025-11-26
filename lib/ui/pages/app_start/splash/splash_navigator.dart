import 'package:todo_app/common/app_navigator.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/router/router_config.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator({required super.context});

  Future<void> openOnBoardingPage() {
    return pushReplacementName(AppRouter.onBoarding);
  }

  Future<void> openHomePage(List<TodoEntity> todos) {
    return pushReplacementName(AppRouter.home, arguments: todos);
  }
}
