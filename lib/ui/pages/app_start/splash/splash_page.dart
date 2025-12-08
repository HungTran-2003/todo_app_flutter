import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/global_provider/app_provider.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/repositories/notification_repository.dart';
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
          notificationRepository: context.read<NotificationRepository>(),
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

class _SplashChildPageState extends State<SplashChildPage>
    with SingleTickerProviderStateMixin {
  late SplashProvider _localProvider;
  late TodoProvider _todoProvider;

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _localProvider = context.read<SplashProvider>();
    _todoProvider = context.read<TodoProvider>();
    _setup();
    _startAnimation();
  }

  void _startAnimation() async {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _controller.forward().then((_) async {
      await _localProvider.initializeApp();
    });
  }

  void _setup() async {
    await _todoProvider.getInitSettings();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: _offsetAnimation,
          child: Column(
            spacing: 8,
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
      ),
    );
  }
}
