import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/configs/app_configs.dart';
import 'package:todo_app/global_provider/app_provider.dart';
import 'package:todo_app/common/app_themes.dart';
import 'package:todo_app/router/router_config.dart';

import 'database/app_share_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharePreferences.init();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: AppConfigs.supabaseUrl,
    anonKey: dotenv.env['API_KEY'] ?? "",
  );
  runApp(
    ChangeNotifierProvider(create: (_) => TodoProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: AppThemes().theme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
