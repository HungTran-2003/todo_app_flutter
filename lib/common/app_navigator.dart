import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  BuildContext context;

  AppNavigator({required this.context});

  void pop(){
    GoRouter.of(context).pop();
  }

  Future<dynamic> pushName(String name){
    return GoRouter.of(context).pushNamed(name);
  }

  Future<dynamic> pushReplacementName(String name){
    return GoRouter.of(context).pushReplacementNamed(name);
  }


}