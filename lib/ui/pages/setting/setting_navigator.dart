import 'package:todo_app/common/app_navigator.dart';
import 'package:todo_app/router/router_config.dart';

class SettingNavigator extends AppNavigator {
  SettingNavigator({required super.context});

  Future<void> openMoviePage(){
    return pushName(AppRouter.movie);
  }

  Future<void> openFocusPage(){
    return pushName(AppRouter.focus);
  }
}
