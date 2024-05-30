import 'package:flutter/material.dart';
import 'package:the_company/utils/constants/image_strings.dart';

import '../../utils/constants/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
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
