import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/devices.dart';
import 'package:survey/info.dart';
import 'package:survey/widgets/customtextfield.dart';
import 'package:survey/info.dart';

class Sight extends StatefulWidget {
  const Sight({super.key});

  @override
  State<Sight> createState() => SightState();
}

class SightState extends State<Sight>
    with AutomaticKeepAliveClientMixin<Sight> {
  //......................Variable and Key Declaration................

  sightbuttoncall(index) {
    if (index == 0) {
      setState(() {
        InfoState.sights.insert(InfoState.sights.length, {
          "label": "Sight ${InfoState.sights.length + 1}",
          "name": "",
          "address": "",
          "email": "",
          "phone": "",
          "check": false,
          "devices": []
        });
        print("widget Added ${InfoState.sights}");
      });
    } else {
      setState(() {
        InfoState.sights.removeAt(index);
        print("widget removed ${InfoState.sights}");
      });
    }
  }

  //.....................FUNCTIONS.........................................
  @override
  bool get wantKeepAlive => true;
  ScrollController scrollController = ScrollController();
  scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
    return ListView.separated(
        shrinkWrap: true,
        controller: scrollController,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: InfoState.sights.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 80,
                  decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  // margin: const EdgeInsets.only(bottom: 200),
                  child: Text(
                    InfoState.sights[index]['label'],
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 15, right: 21, left: 280),
                  height: 35,
                  width: 89,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                          left: 0,
                        ),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      sightbuttoncall(index);
                      print(InfoState.sights[0]['devices'].length);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        index == 0
                            ? const Icon(
                                Icons.add,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                        Text(
                          index == 0 ? "Add" : "Rem",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        )
                      ],
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  "Name",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Stack(children: [
                Container(
                  margin: const EdgeInsets.only(top: 3, left: 20, right: 20),
                  height: 50,
                  decoration: ShapeDecoration(
                      color: Colors.black.withOpacity(0.05000000074505806),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 3, right: 40),
                  child: CustomTextField(
                    type: "sight",
                    onChange: (value) {
                      InfoState.sights[index]['name'] = value.toString();
                    },
                    enable: !InfoState.sights[index]['check'],
                    hintText: "Enter name",
                    copydata: InfoState.name,
                  ),
                ),
              ]),
              Container(
                // color: Colors.brown,
                margin: const EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  "Address",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Stack(children: [
                Container(
                  margin: const EdgeInsets.only(top: 3, left: 20, right: 20),
                  height: 50,
                  decoration: ShapeDecoration(
                      color: Colors.black.withOpacity(0.05000000074505806),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, top: 3, right: 40),
                    child: CustomTextField(
                      type: "sight",
                      onChange: (value) {
                        InfoState.sights[index]['address'] = value.toString();
                      },
                      enable: !InfoState.sights[index]['check'],
                      hintText: "Enter address",
                      copydata: InfoState.address,
                    ))
              ]),
              Container(
                // color: Colors.brown,
                margin: const EdgeInsets.only(top: 8, left: 20),
                child: Text(
                  "Email",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Stack(children: [
                Container(
                  margin: const EdgeInsets.only(top: 3, left: 20, right: 20),
                  height: 50,
                  decoration: ShapeDecoration(
                      color: Colors.black.withOpacity(0.05000000074505806),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 3, right: 40),
                  child: CustomTextField(
                    type: "sight",
                    onChange: (value) {
                      InfoState.sights[index]['email'] = value.toString();
                    },
                    enable: !InfoState.sights[index]['check'],
                    hintText: "Enter email",
                    copydata: InfoState.email,
                  ),
                ),
              ]),
              Container(
                // color: Colors.brown,
                margin: const EdgeInsets.only(top: 9, left: 20),
                child: Text(
                  "Phone Number",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Stack(children: [
                Container(
                    margin: const EdgeInsets.only(top: 3, left: 20, right: 20),
                    height: 50,
                    decoration: ShapeDecoration(
                        color: Colors.black.withOpacity(0.05000000074505806),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                Padding(
                    padding: const EdgeInsets.only(top: 3, left: 20, right: 40),
                    child: CustomTextField(
                      type: "sight",
                      onChange: (value) {
                        InfoState.sights[index]['phone'] = value.toString();
                      },
                      enable: !InfoState.sights[index]['check'],
                      hintText: "Enter Phone number",
                      copydata: InfoState.number,
                    )),
              ]),
              Container(
                height: 22,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10, left: 250),
                child: index == 0
                    ? const SizedBox()
                    : MaterialButton(
                        onPressed: () {

                          setState(() {
                            InfoState.sights[index]['devices'].addAll([
                              {
                                "sight": "Sight ${InfoState.sights.length}",
                                "label": "Panel information",
                                "type": "panel",
                                "image": "",
                                "information": "",
                                "checked": false
                              },
                              {
                                "sight": "Sight ${InfoState.sights.length}",
                                "label": "AC",
                                "type": "panel",
                                "image": "",
                                "information": "",
                                "checked": false
                              },
                              {
                                "sight": "Sight ${InfoState.sights.length}",
                                "label": "Heater information",
                                "type": "panel",
                                "image": "",
                                "information": "",
                                "checked": false
                              },
                              {
                                "sight": "Sight ${InfoState.sights.length}",
                                "label": "PowerX setup",
                                "type": "panel",
                                "image": "",
                                "information": "",
                                "checked": false
                              }
                            ]);
                            InfoState.sights;
                          });
                          print(InfoState.sights);
                        },
                        color: Colors.black,
                        child: const Text(
                          "Add Device",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 30, right: 20),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 38,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 1),
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            value: InfoState.sights[index]['check'],
                            onChanged: (value) {
                              setState(() {
                                InfoState.sights[index]['check'] = value;
                                if (value == true) {
                                  InfoState.sights[index]['name'] =
                                      InfoState.name;
                                  InfoState.sights[index]['address'] =
                                      InfoState.address;
                                  InfoState.sights[index]['email'] =
                                      InfoState.email;
                                  InfoState.sights[index]['phone'] =
                                      InfoState.number;
                                  print(InfoState.sights);
                                } else {
                                  print(InfoState.sights);
                                }
                              });
                            },
                            activeColor: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        "Copy From Customer Information",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color:
                                Colors.black.withOpacity(0.6000000238418579)),
                      )
                    ],
                  ))
            ],
          );
        });
  }
}
