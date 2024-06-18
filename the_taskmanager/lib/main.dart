import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_taskmanager/data/services/theme_services.dart';
import 'package:the_taskmanager/presentation/screens/home/home_screen.dart';
import 'package:the_taskmanager/presentation/screens/splash/splash_screen.dart';
import 'package:the_taskmanager/utils/routes/app_router.dart';
import 'package:the_taskmanager/utils/theme/theme.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.getPages,
      initialRoute:RouteName.splashScreen,
      locale: const Locale('en', 'IN'),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeServices().theme
    );
  }
}
