import 'package:todo_app/common/app_navigator.dart';
import 'package:todo_app/router/router_config.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator({required super.context});

  Future<void> openOnBoardingPage(){
    return pushReplacementName(AppRouter.onBoarding);
  }

  Future<void> openHomePage() {
    return pushReplacementName(AppRouter.home);
  }

}