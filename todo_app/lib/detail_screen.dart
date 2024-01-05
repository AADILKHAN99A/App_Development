import 'package:flutter/material.dart';
import 'package:todo_app/ui_elements.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen(this.item, {super.key});
  final Map item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              )),
          elevation: 0,
          title: const Text(
            'Details',
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.21, -0.98),
                end: Alignment(0.21, 0.98),
                colors: [
                  Color(0xFF5E54F6),
                  Color(0xFFF6A5CB),
                  Color(0xFFC37050)
                ],
              ),
            ),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              // Main Paper
              PaperWithTextFields(
                data: item,
                readOnly: true,
              ),
              // Clips of Paper
              Align(alignment: Alignment.topCenter, child: clips(context)),
              backPaper(context),
            ])));
  }
}
