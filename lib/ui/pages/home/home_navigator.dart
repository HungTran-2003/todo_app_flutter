import 'package:todo_app/common/app_navigator.dart';
import 'package:todo_app/router/router_config.dart';

class HomeNavigator extends AppNavigator {
  HomeNavigator({required super.context});

  Future<void> openDetailPage({int? todoId}) async{
    pushName(AppRouter.detail);
  }
}
