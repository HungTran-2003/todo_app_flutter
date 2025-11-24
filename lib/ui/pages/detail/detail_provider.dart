import 'package:flutter/widgets.dart';
import 'package:todo_app/ui/pages/detail/detail_navigator.dart';

class DetailProvider extends ChangeNotifier{
  final DetailNavigator navigator;

  DetailProvider({required this.navigator});
}