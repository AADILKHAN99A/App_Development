import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_news/presentation/home/home_screen.dart';
import 'package:the_news/presentation/landing/landing_screen.dart';
import 'package:the_news/presentation/splash/splash_screen.dart';
import 'package:the_news/providers/home_provider.dart';
import 'package:the_news/providers/landing_provider.dart';

class RoutesNames {
  static const String homeScreen = "home_screen";
  static const String splashScreen = "splash_screen";
  static const String landingScreen = "landing_screen";
}

class AppRoutes {
  static Route<dynamic>? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.homeScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => HomeProvider(),
                child: const HomeScreen()));

      case RoutesNames.landingScreen:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => LandingProvider(),
                child: const LandingScreen()));

      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      default:
        return null;
    }
  }
}
