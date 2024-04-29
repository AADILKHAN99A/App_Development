import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/helper_widgets.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key, required this.callback,required this.resumeImageLink});

  final VoidCallback callback;
  final String  resumeImageLink;

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              margin: const EdgeInsets.only(top: 100,right: 150,left: 150,bottom: 50),
              child: Image.network("https://drive.google.com/uc?export=view&id=1gqwACMF3kaXKsP3SfJ3BPWUuodaOvOoS",
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                print("Failed to Load Image");
                  return  Center(
                    child: Image.asset('assets/resume.png'),
                  );
                },),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25,top: 10),
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
