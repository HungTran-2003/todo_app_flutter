import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/onboarding_page.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_navigator.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_page.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_provider.dart';
import 'package:todo_app/ui/pages/home/home_page.dart';

class AppRouter {
  AppRouter._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    routes: _routes,
    navigatorKey: navigationKey,
  );

  static const String splash = "/";
  static const String onBoarding = "onboarding";
  static const String home = "home";

  static final _routes = <RouteBase> [
    GoRoute(
      path: splash,
      builder: (context, state) {
        final navigator = SplashNavigator(context: context);
        return SplashPage(navigator: navigator);
      },
      routes: [
        GoRoute(
          name: onBoarding,
          path: onBoarding,
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          name: home,
          path: home,
          builder: (context, state) => const HomePage(),
        )
      ]
    )
  ];

}