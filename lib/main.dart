import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/configs/app_configs.dart';

import 'database/app_share_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharePreferences.init();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: AppConfigs.supabaseUrl,
    anonKey: dotenv.env['API_KEY'] ?? "",
  );
  runApp(const MyApp());
}