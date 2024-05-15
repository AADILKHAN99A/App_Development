import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses/screens/login_screen/login_screen.dart';
import 'package:the_expenses/screens/login_screen/provider/login_provider.dart';
import 'package:the_expenses/screens/splash_screen/splash_screen.dart';

import '../screens/home_screen/home_screen.dart';
import '../screens/home_screen/provider/home_provider.dart';
import '../screens/signup_screen/provider/signup_provider.dart';
import '../screens/signup_screen/signup_screen.dart';

class RouteName {
  static const String loginScreen = '/login_screen';
  static const String splashScreen = '/splash_screen';

  static const String homeScreen = '/home_screen';
  static const String signUpScreen = '/signup_screen';
}

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RouteName.loginScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => LogInProvider(),
                child: const LoginScreen()));

      case RouteName.homeScreen:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) => HomeProvider(),
                  child: HomeScreen(
                    args: args,
                  ),
                ));

      case RouteName.signUpScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) => SignUpProvider(),
                  child: const SignUpScreen(),
                ));

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(
                    child: Text("OOps! Something Wrong"),
                  ),
                ));
    }
  }
}
