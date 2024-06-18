import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:the_company/features/authentication/screens/login/login.dart';
import 'package:the_company/features/authentication/screens/splash/splash.dart';
import 'package:the_company/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      // initialRoute: 'splash',
      // onGenerateRoute: FRouter.router.generator,
      onUnknownRoute: (unknownRoutes) {
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'The Company',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
