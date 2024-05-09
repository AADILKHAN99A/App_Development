import 'package:flutter/Material.dart';
import 'package:the_employee/routes/app_routes.dart';

import 'package:the_employee/utils/color_constants.dart';
import 'package:the_employee/utils/image_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, RouteName.logInScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(darkBlue),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              userImage,
              scale: 5,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "The Employee",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    ));
  }
}
