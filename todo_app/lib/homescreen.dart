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
        print(result);
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
                  left: 25,
                  child: SizedBox(
                    width: 340,
                    height: 560,
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
                          height: 50,
                        );
                      },
                    ),
                  )),
              isLoading == true
                  ? const Positioned(
                      top: 300,
                      left: 170,
                      child: CircularProgressIndicator(
                        color: Color(0xFF5E54F6),
                      ))
                  : Positioned(
                      top: 25,
                      left: 25,
                      child: SizedBox(
                        width: 350,
                        height: 560,
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
                                              builder: (builder) =>
                                                  UpdateScreen(
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
                                    onPressed: () {
                                      deleteData(id: id);
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
                              height: 5,
                            );
                          },
                        ),
                      ),
                    ),
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
      ),
    );
  }
}
