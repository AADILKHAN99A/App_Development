import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/theming.dart';

class AboutScreenMobileLayout extends StatefulWidget {
  const AboutScreenMobileLayout({super.key});

  @override
  State<AboutScreenMobileLayout> createState() =>
      _AboutScreenMobileLayoutState();
}

class _AboutScreenMobileLayoutState extends State<AboutScreenMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 150, bottom: 15),
              child: Text(
                "About Me",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(ThemeColors.aboutTextColor)),
              ),
            ),
            const Text(
              "I Am Aadil Khan, Flutter Developer",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20, bottom: 40),
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  style: TextStyle(color: Color(0xffebefff), fontSize: 16),
                  "Experienced Flutter Developer with skilled in Cross Platform Application Development. Build's project on it, Strong engineering professional with a Bachelor Degree in Technology from RTU.",
                  softWrap: true,
                )),
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text("Skills",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(ThemeColors.aboutTextColor)))),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: 55,
                      child: Image.asset("assets/flutter_icon.png")),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 2),
                    child: SizedBox(
                        height: 45,
                        child: Image.asset("assets/firebase_icon.png")),
                  ),
                  SizedBox(
                      height: 45,
                      child: Image.asset("assets/androidStudio_icon.png")),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: SizedBox(
                        height: 45, child: Image.asset("assets/sql_icon.png")),
                  ),
                  SizedBox(
                      height: 53, child: Image.asset("assets/api_icon.png")),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 5),
                    child: CircleAvatar(
                      radius: 3,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 3),
                    child: CircleAvatar(
                      radius: 3,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 3),
                    child: CircleAvatar(
                      radius: 3,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
