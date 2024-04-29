import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/helper_widgets.dart';

class ContactScreenMobileLayout extends StatefulWidget {
  const ContactScreenMobileLayout({super.key});

  @override
  State<ContactScreenMobileLayout> createState() =>
      _ContactScreenMobileLayoutState();
}

class _ContactScreenMobileLayoutState extends State<ContactScreenMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "What's Next ?",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text("Get In Touch",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20, bottom: 40),
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  style: TextStyle(color: Color(0xffebefff), fontSize: 18),
                  "Your go-to Cross-Platform App Developer, ready to bring your dream project to life in the virtual world. From Making Apps for small and medium-sized businesses to empowering you by building your dream tech product, I've got the skills and expertise to make it happen.",
                  softWrap: true,
                )),
            Container(
                margin: const EdgeInsets.only(top: 20, bottom: 40),
                width: MediaQuery.of(context).size.width / 2,
                child: const Text(
                  style: TextStyle(color: Color(0xffebefff), fontSize: 20),
                  "Let's build something Awesome!",
                  softWrap: true,
                )),
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
      ),
    );
  }
}
