import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controller.dart';
import 'package:portfolio/screens/home_page.dart';
import 'package:portfolio/screens/page_root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MyController controller = Get.put(MyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.updateAllData();
    Timer(const Duration(seconds: 5), () {
      Get.offAll(PageRoot());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/loading_animation.gif"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
