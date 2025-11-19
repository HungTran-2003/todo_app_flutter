import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_navigator.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_provider.dart';
import 'package:todo_app/ui/widgets/loading/app_loading_indicator.dart';

class SplashPage extends StatefulWidget {
  final SplashNavigator navigator;

  const SplashPage({super.key, required this.navigator});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashProvider provider;

  @override
  void initState() {
    super.initState();
    provider = SplashProvider(widget.navigator);
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<SplashProvider>.value(
      value: provider,
      child: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Column(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.splashScreen),
                    ]
                ),
              ),
            );
          }
      ),
    );
  }
}


