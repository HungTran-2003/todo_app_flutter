import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/global_provider/app_provider.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_navigator.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SplashProvider(
          navigator: SplashNavigator(context: context),
          authRepository: context.read<AuthRepository>(),
          todoRepository: context.read<TodoRepository>(),
        );
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
  late SplashProvider _localProvider;
  late TodoProvider _todoProvider;

  @override
  void initState() {
    super.initState();
    _localProvider = context.read<SplashProvider>();
    _todoProvider = context.read<TodoProvider>();
    _setup();
  }

  void _setup() async {
    await Future.delayed(const Duration(seconds: 1));
    await _todoProvider.getInitSettings();
    log("build");
    WidgetsBinding.instance.addPostFrameCallback((_) async { await _localProvider.login(); });

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
                    if (!provider.isLoading) {
                      return const SizedBox.shrink();
                    }
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
