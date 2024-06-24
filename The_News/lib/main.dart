import 'package:flutter/material.dart';
import 'package:the_news/presentation/home/home_screen.dart';
import 'package:the_news/utils/routes/routes.dart';
import 'package:the_news/utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The News',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRoutes.generateRoutes,
      initialRoute: RoutesNames.splashScreen,
      themeMode: ThemeMode.system,
    );
  }
}
