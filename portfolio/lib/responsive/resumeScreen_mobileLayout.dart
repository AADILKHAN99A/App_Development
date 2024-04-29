import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResumeMobilePage extends StatefulWidget {
  const ResumeMobilePage({super.key, required this.callback,required this.resumeImageLink});

  final VoidCallback callback;
  final String resumeImageLink;

  @override
  State<ResumeMobilePage> createState() => _ResumeMobilePageState();
}

class _ResumeMobilePageState extends State<ResumeMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 60, right: 50, left: 50, bottom: 50),
              child: Image.network(widget.resumeImageLink),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25, top: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      side: const BorderSide(color: Colors.white)),
                  onPressed: () {
                    widget.callback();
                  },
                  child: const Text(
                    "Download",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
