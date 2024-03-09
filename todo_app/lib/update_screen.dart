import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller.dart';
import 'package:todo_app/ui_elements.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.item});
  final Map item;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final MyController controller = Get.put(MyController());
  final GlobalKey<PaperWithTextFieldsState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: SizedBox(
          height: 45,
          width: 45,
          child: Container(
            decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.1, 0.95),
                  colors: [
                    Color(0xFF5E54F6),
                    Color(0xFF776EE0),
                    Color(0xFF5E54F6),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                // do something
                key.currentState?.updateData();
              },
              tooltip: "Add Note",
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                controller.doRefresh
                    ? Navigator.pop(context, true)
                    : Navigator.pop(context, false);
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Edit Todo',
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
                key: key,
                data: widget.item,
              ),
              // Clips of Paper
              Align(alignment: Alignment.topCenter, child: clips(context)),
              backPaper(context),
            ])));
  }
}
