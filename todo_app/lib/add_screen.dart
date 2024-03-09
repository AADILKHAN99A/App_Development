import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/controller.dart';

import 'api_handler.dart';

class AddScreen extends StatefulWidget {
  AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();

  final MyController controller = Get.put(MyController());

  Future<void> submitData() async {
    final title = titleController.text;
    final description = desController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    await http.post(uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'}).then((response) {
      if (response.statusCode == 201) {
        titleController.text = "";
        desController.text = "";
        ShowMessage.showSuccessMessage("Created Successfully", context);
        controller.doRefresh = true;
        setState(() {});
      } else {
        ShowMessage.showErrorMessage("Failed", context);
      }
    });
  }

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
            onPressed: submitData,
            tooltip: "Save",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.save),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        title: const Text(
          'Add',
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
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.21, -0.98),
            end: Alignment(0.21, 0.98),
            colors: [Color(0xFF5E54F6), Color(0xFFF6A5CB), Color(0xFFC37050)],
          ),
        ),
        child: SizedBox(
          child: Stack(children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 50, left: 20, right: 20, bottom: 93),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(18)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40, left: 25),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 24,
                    height: 44,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 20,
                          child: Container(
                            width: 24,
                            height: 18,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFD6D6D6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -0,
                          top: 21.90,
                          child: Container(
                            width: 24,
                            height: 16.10,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE9E9E9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 6,
                          top: 0,
                          child: SizedBox(
                            height: 38,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 4,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF4D4D4D),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  width: 4,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF4D4D4D),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 21,
                  );
                },
              ),
            ),
            Positioned(
                top: 25,
                left: 23,
                child: SizedBox(
                  width: 345,
                  height: 560,
                  child: ListView(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(hintText: "Title"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: desController,
                        decoration:
                            const InputDecoration(hintText: "Description"),
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 8,
                      )
                    ],
                  ),
                )),
            Positioned(
                top: 620,
                left: 35,
                child: Container(
                  width: 320,
                  height: 8,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(1.00, 0.02),
                      end: const Alignment(-1, -0.02),
                      colors: [
                        Colors.white.withOpacity(0.6000000238418579),
                        Colors.white.withOpacity(0.20000000298023224)
                      ],
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                )),
            Positioned(
                top: 627,
                left: 45,
                child: Container(
                  width: 300,
                  height: 8,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(1.00, 0.02),
                      end: const Alignment(-1, -0.02),
                      colors: [
                        Colors.white.withOpacity(0.6000000238418579),
                        Colors.white.withOpacity(0.20000000298023224)
                      ],
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                )),
            Positioned(
                top: 634,
                left: 55,
                child: Container(
                  width: 280,
                  height: 8,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(1.00, 0.02),
                      end: const Alignment(-1, -0.02),
                      colors: [
                        Colors.white.withOpacity(0.6000000238418579),
                        Colors.white.withOpacity(0.20000000298023224)
                      ],
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
