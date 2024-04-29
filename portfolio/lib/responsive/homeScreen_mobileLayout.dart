import 'package:flutter/material.dart';

import '../components/helper_widgets.dart';

class HomeScreenMobileLayout extends StatefulWidget {
  const HomeScreenMobileLayout({super.key});

  @override
  State<HomeScreenMobileLayout> createState() => _HomeScreenMobileLayoutState();
}

class _HomeScreenMobileLayoutState extends State<HomeScreenMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              "Hi! I am.",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Text(
            "Aadil Khan",
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.w800),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: const Text(
              "I Build Cross Platform Applications",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey),
            ),
          ),
          const Text(
            "Developer Who Exploring New things In Dev Part of IT World",
            style: TextStyle(fontSize: 11),
            softWrap: true,
          ),
          const Spacer(
            flex: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100, right: 60),
            child: Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      side: const BorderSide(color: Colors.white)),
                  onPressed: () {
                    Message().showPopUpMessage(context);
                  },
                  child: const Text(
                    "Get In Touch",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
