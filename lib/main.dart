import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/global_provider/app_provider.dart';
import 'package:todo_app/common/app_themes.dart';
import 'package:todo_app/router/router_config.dart';

import 'database/app_share_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharePreferences.init();
  runApp(
    ChangeNotifierProvider(create: (_) => TodoProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppThemes().theme,
      routerConfig: AppRouter.router,
    );
  }
}
