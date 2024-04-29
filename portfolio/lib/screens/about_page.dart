import 'package:flutter/material.dart';
import 'package:portfolio/components/theming.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 150, bottom: 15),
              child: Text(
                "About Me",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(ThemeColors.aboutTextColor)),
              ),
            ),
            const Text(
              "I Am Aadil Khan, Flutter Developer",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20, bottom: 40),
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  style: TextStyle(color: Color(0xffebefff), fontSize: 20),
                  "Experienced Flutter Developer with skilled in Cross Platform Application Development and creating user-friendly interfaces. Build project's on it, Strong engineering professional with a Bachelor Degree in Technology from RTU.",
                  softWrap: true,
                )),
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text("Skills",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(ThemeColors.aboutTextColor)))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 60, child: Image.asset("assets/flutter_icon.png")),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 5),
                  child: SizedBox(
                      height: 50,
                      child: Image.asset("assets/firebase_icon.png")),
                ),
                SizedBox(
                    height: 50,
                    child: Image.asset("assets/androidStudio_icon.png")),
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: SizedBox(
                      height: 50, child: Image.asset("assets/sql_icon.png")),
                ),
                SizedBox(height: 58, child: Image.asset("assets/api_icon.png")),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 5),
                  child: CircleAvatar(
                    radius: 5,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 3),
                  child: CircleAvatar(
                    radius: 5,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 3),
                  child: CircleAvatar(
                    radius: 5,
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
