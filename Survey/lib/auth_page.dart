import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:survey/login_page.dart';
import 'package:survey/survey_list.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return SurveyList(id: snapshot.data?.uid);
          }
          // user is not logged in
          else {
            return  const Login();
          }
        },
      ),
    );
  }
}
