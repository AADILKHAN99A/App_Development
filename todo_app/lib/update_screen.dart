import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateScreen extends StatefulWidget {
  UpdateScreen({super.key, required this.item});
  final Map item;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController desController = TextEditingController();
  bool doRefresh = false;
  @override
  void initState() {
    super.initState();
    titleController.text = widget.item['title'];
    desController.text = widget.item['description'];
  }

  Future<void> updateData() async {
    final url = 'https://api.nstack.in/v1/todos/${widget.item['_id']}';
    final uri = Uri.parse(url);
    final title = titleController.text;
    final description = desController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      doRefresh = true;
      showSuccessMessage("Update Successful");
    } else {
      showErrorMessage("Failed Update");
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.blueAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    throw Exception("Failed to Post");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: updateData,
            tooltip: "Add Note",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.check),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              doRefresh
                  ? Navigator.pop(context, true)
                  : Navigator.pop(context, false);
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Edit Todo',
          style: TextStyle(
              fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w500),
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
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                height: 570,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
              ),
            ),
            Positioned(
              top: 40,
              left: 25,
              child: SizedBox(
                width: 350,
                height: 500,
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
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    width: 4,
                                    height: 32,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF4D4D4D),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
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
