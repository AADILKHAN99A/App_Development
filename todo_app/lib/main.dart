import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('To-Do App'),
          flexibleSpace: Container(
            decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.1, 0.95),
                  colors: [
                    Color(0xFF8883D5),
                    Color(0xFF776EE0),
                    Color(0xFF5E54F6),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  side: BorderSide(
                    width: 1.10,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Colors.white24,
                  ),
                ),
                shadows: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 10)
                ]),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 70),
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.21, -0.98),
              end: Alignment(0.21, 0.98),
              colors: [Color(0xFF5E54F6), Color(0xFFF6A5CB), Color(0xFFC37050)],
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60),
                height: 560,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
