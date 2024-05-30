import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_company/firebase_options.dart';
import 'package:get/get.dart';
import 'package:the_company/utils/routes.dart';
import 'package:the_company/presentation/login_screen/login_page.dart';
import 'package:the_company/utils/theme/theme.dart';

import 'app.dart';

void main() async {
  // TODO: Init Local Storage
  // TODO: Await Native Splash
  // TODO: Initialize Firebase
  // TODO: Initialize Authentication

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FRouter.setupRouter();
  runApp(const App());
}


