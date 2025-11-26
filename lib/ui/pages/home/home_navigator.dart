import 'package:todo_app/common/app_navigator.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/router/router_config.dart';

class HomeNavigator extends AppNavigator {
  HomeNavigator({required super.context});

  Future<bool> openDetailPage({TodoEntity? todo}) async{
    return await pushName(AppRouter.detail, arguments: todo);
  }
}
