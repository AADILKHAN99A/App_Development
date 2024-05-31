import 'package:flutter/material.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';
import '../../../../utils/constants/image_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Container(
        // Background
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    CImages.blueBackgroundWithRoundBorderSquarePatterns),
                fit: BoxFit.cover)),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              /// Logo

              LoginHeader(),


              // login form with foreground content
              LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
