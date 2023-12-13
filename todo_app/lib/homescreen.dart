import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/add_screen.dart';
import 'package:todo_app/data_models.dart';
import 'package:todo_app/detail_screen.dart';
import 'package:todo_app/update_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Todo> todoList = [];
  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map;
      final result = data['items'] as List;
      setState(() {
        items = result;
        isLoading = false;
      });
    } else {
      throw Exception("Failed to Load ${response.statusCode}");
    }
  }

  Future<void> deleteData({required String id}) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);

    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage("Delete Failed");
    }
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    throw Exception("Failed to Delete");
  }

  Future showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            icon: const Icon(Icons.warning_amber, color: Color(0xFF5E54F6)),
            title: const Text(
              "Are you sure?",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xFF5E54F6)),
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.white))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xFF5E54F6)),
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Delete",
                      style: TextStyle(color: Colors.white)))
            ],
          ));

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
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => AddScreen()));
              setState(() {
                isLoading = true;
              });
              getData();
            },
            tooltip: "Add Note",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'To-Do App',
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
      body: RefreshIndicator(
        onRefresh: getData,
        child: Container(
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
              ),
              Container(
                width: double.infinity,
                height: 44,
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
                                          borderRadius:
                                          BorderRadius.circular(2)),
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
                                          borderRadius:
                                          BorderRadius.circular(2)),
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60, left: 25, right: 25),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                      thickness: 1,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 47,
                    );
                  },
                ),
              ),
              isLoading == true
                  ? const Center(
                      heightFactor: double.infinity,
                      widthFactor: double.infinity,
                      child: CircularProgressIndicator(
                        color: Color(0xFF5E54F6),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(
                          top: 15, left: 20, right: 20, bottom: 80),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final id = items[index]['_id'] as String;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  splashColor: Colors.blue,
                                  onPressed: () async {
                                    if (kDebugMode) {
                                      print("update");
                                    }
                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => UpdateScreen(
                                                  item: items[index],
                                                )));
                                    if (result) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      getData();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  )),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              DetailedScreen(items[index])));
                                },
                                child: Text(
                                  items[index]['title'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              IconButton(
                                  splashColor: Colors.blue,
                                  onPressed: () async {
                                    final result = await showWarning(context);
                                    result == true ? deleteData(id: id) : null;
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ))
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 1,
                          );
                        },
                      ),
                    ),
              Container(
                margin: const EdgeInsets.only(
                    left: 55, top: 640, right: 55, bottom: 61),
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
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 45, top: 630, right: 45, bottom: 72),
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
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 35, top: 620, right: 35, bottom: 82),
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
              )
            ]),
          ),
        ),
      ),
    );
  }
}
