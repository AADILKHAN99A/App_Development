import 'package:flutter/material.dart';
import 'package:portfolio/components/helper_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: const Text(
              "Hi! I am.",
              style: TextStyle(fontSize: 25),
            ),
          ),
          const Text(
            "Aadil Khan",
            style: TextStyle(fontSize: 65, fontWeight: FontWeight.w800),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: const Text(
              "I Build Cross Platform Applications",
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
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
              const Text(
                "Developer Who Exploring New things In Dev Part of IT World",
                softWrap: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}
