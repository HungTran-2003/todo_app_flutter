import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/ui/pages/home/home_navigator.dart';

class HomeProvider extends ChangeNotifier {
  final HomeNavigator navigator;

  HomeProvider({required this.navigator});

  Future<bool> deleteTodo() async {
    final completer = Completer<bool>();
    navigator.showSimpleDialog(
      title: "Delete Todo",
      content: "You want to delete this Todo?",
      textCancel: "Cancel",
      onConfirm: () {
        navigator.showLoadingOverlay();
        completer.complete(true);
      },
      onCancel: () {
        completer.complete(false);
      },
    );
    return completer.future;
  }

  Future<void> openPageDetail({int? todoId}) async{
    await navigator.openDetailPage(todoId: todoId);
  }
}
