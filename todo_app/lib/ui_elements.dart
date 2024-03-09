import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/api_handler.dart';
import 'package:todo_app/controller.dart';
import 'package:todo_app/detail_screen.dart';
import 'package:todo_app/update_screen.dart';

import 'add_screen.dart';

final MyController controller = Get.put(MyController());

Widget backPaper(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 40,
    margin: const EdgeInsets.only(bottom: 53, right: 15, left: 15),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20),
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
        ),
        Container(
          height: 12,
          margin: const EdgeInsets.only(right: 30, left: 30),
          clipBehavior: Clip.antiAlias,
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
          height: 12,
          margin: const EdgeInsets.only(right: 40, left: 40),
          clipBehavior: Clip.antiAlias,
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
      ],
    ),
  );
}

Widget clips(BuildContext context) {
  return Container(
    height: 44,
    // color: Colors.black54,
    margin: const EdgeInsets.only(left: 30, top: 43),
    child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: SizedBox(
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
          ),
        );
      },
    ),
  );
}

class PaperWithList extends StatefulWidget {
  const PaperWithList({super.key});

  @override
  State<PaperWithList> createState() => _PaperWithListState();
}

class _PaperWithListState extends State<PaperWithList> {
  bool isLoading = true;
  List list = [];

  Future refreshList() async {
    await ApiHelper.fetchPost().then((result) {
      if (result != null) {
        ShowMessage.showSuccessMessage("Data Fetch Successfully", context);
        print(result);
        list = result;
        list.add({"title": "Add task++01"});
        isLoading = false;
        setState(() {});
      } else {
        ShowMessage.showErrorMessage("Error", context);
      }
    });
  }

  delete({required String id, required List items}) async {
    await ApiHelper.deletePost(id: id, items: items).then((result) {
      if (result) {
        ShowMessage.showSuccessMessage("Successfully Deleted", context);
        refreshList();
      } else {
        ShowMessage.showErrorMessage("Error Deleting", context);
      }
    });
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
  void initState() {
    super.initState();
    refreshList();
  }

  final MyController controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 93),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: RefreshIndicator(
        onRefresh: refreshList,
        child: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: ListView.separated(
            itemCount: list.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return index < list.length
                  ? list[index]["title"] == "Add task++01"
                      ? InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => AddScreen()));
                            if (result) {
                              controller.reset();
                              refreshList();
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.grey,
                              ),
                              Text(
                                "Add task",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0.09,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => UpdateScreen(
                                                item: list[index])));
                                    if (result) {
                                      controller.reset();
                                      refreshList();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  )),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              DetailedScreen(list[index])));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 20,
                                  child: Text(
                                    list[index]["title"],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0.09,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    showWarning(context).then((result) {
                                      if (result) {
                                        delete(
                                            id: list[index]["_id"],
                                            items: list);
                                      }
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  )),
                            ],
                          ))
                  : const Text("");
            },
            separatorBuilder: (BuildContext context, int index) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  itemCount: list.length == index + 1 ? 11 - list.length : 1,
                  itemBuilder: (BuildContext context, int interIndex) {
                    return Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: list.length == index + 1
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: const Divider(
                                  height: 1,
                                  thickness: 1,
                                ),
                              )
                            : const Divider(
                                height: 1,
                                thickness: 1,
                              ));
                  });
            },
          ),
        ),
      ),
    );
  }
}

class PaperWithTextFields extends StatefulWidget {
  const PaperWithTextFields({super.key, required this.data, this.readOnly});
  final Map data;
  final bool? readOnly;

  @override
  State<PaperWithTextFields> createState() => PaperWithTextFieldsState();
}

class PaperWithTextFieldsState extends State<PaperWithTextFields> {
  final titleController = TextEditingController();
  final desController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.data['title'];
    desController.text = widget.data['description'];
  }

  updateData() async {
    await ApiHelper.updatePost(
            id: widget.data["_id"],
            title: titleController.text,
            description: desController.text)
        .then((result) {
      if (result) {
        ShowMessage.showSuccessMessage("Updated Successfully", context);
        controller.doRefresh = true;
      } else {
        ShowMessage.showErrorMessage("Update Error", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 93),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 50),
        child: Column(
          children: [
            TextField(
              readOnly: widget.readOnly == true ? true : false,
              controller: titleController,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: desController,
              readOnly: widget.readOnly == true ? true : false,
              decoration: const InputDecoration(hintText: "Description"),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
            )
          ],
        ),
      ),
    );
  }
}
