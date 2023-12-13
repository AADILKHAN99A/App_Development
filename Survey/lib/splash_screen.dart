import 'dart:async';
import 'package:flutter/material.dart';
import 'package:survey/auth_page.dart';
import 'package:survey/database_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    super.initState();
    dbHelper.db;
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const AuthPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: const Center(
          child: Text(
            "Survey App",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
