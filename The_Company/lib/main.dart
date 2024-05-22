import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_company/firebase_options.dart';
import 'package:get/get.dart';
import 'package:the_company/utils/routes.dart';
import 'package:the_company/presentation/login_screen/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FRouter.setupRouter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: 'splash',
      onGenerateRoute: FRouter.router.generator,
      onUnknownRoute: (unknownRoutes) {
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'The Company',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
