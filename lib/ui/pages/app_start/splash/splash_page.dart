
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/global_provider/app_provider.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_navigator.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_provider.dart';

class SplashPage extends StatefulWidget {
  final SplashNavigator navigator;

  const SplashPage({super.key, required this.navigator});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = SplashProvider(widget.navigator);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<TodoProvider, bool>((p) => p.isLoading);
    if (isLoading == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _provider.nextPage();
      });
    }

    return ChangeNotifierProvider<SplashProvider>.value(
      value: _provider,
      child: Builder(
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
                        child: isLoading ? const CircularProgressIndicator() : null,
                      ),
                      Text(
                        isLoading ? "Connect to the server" : "Success",
                        style: AppTextStyles.bMediumMedium,
                      ),
                    ]
                ),
              ),
            );
          }
      ),
    );
  }
}


