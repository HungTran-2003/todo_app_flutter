import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/onboarding_navigator.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/onboarding_page.dart';
import 'package:todo_app/ui/pages/app_start/splash/splash_page.dart';
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

  static final _routes = <RouteBase>[
    GoRoute(
      path: splash,
      builder: (context, state) => const SplashPage(),
      routes: [
        GoRoute(
          name: onBoarding,
          path: onBoarding,
          builder: (context, state) {
            final navigator = OnboardingNavigator(context: context);
            return OnboardingPage(navigator: navigator);
          },
        ),
        GoRoute(
          name: home,
          path: home,
          builder: (context, state) => const HomePage(),
        ),
      ],
    ),
  ];
}
