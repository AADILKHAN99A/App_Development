import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/firebase_options.dart';
import 'package:survey/info.dart';
import 'package:survey/login_page.dart';
import 'package:survey/signup_page.dart';
import 'package:survey/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Survey());
}

class Survey extends StatelessWidget {
  const Survey({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Survey',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/Login', page: () => const Login()),
        GetPage(name: '/SignUp', page: () => const SignUpPage()),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.grey, selectionHandleColor: Colors.black),
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
