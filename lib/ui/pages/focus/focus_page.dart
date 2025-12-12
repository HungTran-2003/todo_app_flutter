import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_svgs.dart';
import 'package:todo_app/ui/pages/focus/focus_navigator.dart';
import 'package:todo_app/ui/pages/focus/focus_provider.dart';
import 'package:todo_app/ui/pages/focus/widgets/clock_widget.dart';
import 'package:todo_app/ui/widgets/app_bar/app_bar_widget.dart';

class FocusPage extends StatelessWidget {
  const FocusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FocusProvider>(
      create: (context){
        return FocusProvider(navigator: FocusNavigator(context: context));
      },
      child: FocusChildPage(),
    );
  }
}

class FocusChildPage extends StatefulWidget {
  const FocusChildPage({super.key});

  @override
  State<FocusChildPage> createState() => _FocusChildPageState();
}

class _FocusChildPageState extends State<FocusChildPage> with TickerProviderStateMixin {

  late FocusProvider _provider;
  late AnimationController _controller;
  final int duration = 98888;


  @override
  void initState() {
    _provider = context.read<FocusProvider>();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds:duration),
    )..value = 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Focus", onPressed: _provider.navigator.pop, imageBackground: AppImages.header2),
      body: Center(
        child: ClockWidget(duration: duration, controller: _controller)
      ),
    );
  }
}

