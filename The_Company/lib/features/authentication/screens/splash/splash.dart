import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_company/features/authentication/screens/onboarding/onboarding.dart';
import 'package:the_company/utils/constants/image_strings.dart';

import '../../../../utils/constants/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const OnboardingScreen());
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: CColors.secondary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Image.asset(
          CImages.loadingGifWithBlueBackground,
          height: 200,
          width: 200,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
