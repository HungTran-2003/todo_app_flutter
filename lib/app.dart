import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/global_provider/app_provider.dart';
import 'package:todo_app/networking/api_client.dart';
import 'package:todo_app/networking/api_utli.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/repositories/notification_repository.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/repositories/user_repository.dart';
import 'package:todo_app/router/router_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/app_themes.dart';
import 'generated/l10n.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.apiClient;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(_apiClient),
        ),

        Provider<TodoRepository>(
          create: (context) => TodoRepositoryImpl(_apiClient),
        ),

        Provider<NotificationRepository>(
          create: (context) => NotificationRepositoryImpl(),
        ),

        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(_apiClient),
        ),

        ChangeNotifierProvider<TodoProvider>(
          create: (context) => TodoProvider(),
        ),
      ],

      child: Selector<TodoProvider, Locale>(
        builder: (context, locale, child) {
          return _buildMaterialApp(locale: locale);
        },
        selector: (context, provider) => provider.locale,
      ),
    );
  }

  Widget _buildMaterialApp({required Locale locale}) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: AppThemes().theme,
        routerConfig: AppRouter.router,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: locale,
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
