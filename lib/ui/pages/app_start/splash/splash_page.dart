import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_navigator.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SplashProvider(navigator: SplashNavigator(context: context));
      },
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late SplashProvider localProvider;

  @override
  void initState() {
    super.initState();
    localProvider = context.read<SplashProvider>();
    _setup();
  }

  void _setup() async {
    await Future.delayed(const Duration(seconds: 1));
    log("build");
    await localProvider.login();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.splashScreen),
                SizedBox(
                  height: 40,
                  child: Consumer<SplashProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                Consumer<SplashProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      provider.message,
                      style: AppTextStyles.bMediumMedium,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
