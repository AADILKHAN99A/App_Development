import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/cstmr.dart';
import 'package:survey/devices.dart';

class Sight extends StatefulWidget {
  const Sight({super.key});

  @override
  State<Sight> createState() => SightState();
}

class SightState extends State<Sight>
    with AutomaticKeepAliveClientMixin<Sight> {
  //......................Variable and Key Declaration................

  static late int len;

  List sights = [
    {
      "label": "1",
      "name": "",
      "address": "",
      "email": "",
      "phone": "",
      "copy": false,
    }
  ];
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  //.....................FUNCTIONS.........................................
  @override
  bool get wantKeepAlive => true;
  ScrollController scrollController = ScrollController();
  scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  buttoncall(int index) {
    if (index == 0) {
      setState(() {
        DevicesState.deviceList.addAll([
          {
            "sight": sights.length,
            "label": "Panel information",
            "type": "panel",
            "image": "",
            "information": "",
            "checked": false
          },
          {
            "sight": sights.length + 1,
            "label": "AC",
            "type": "panel",
            "image": "",
            "information": "",
            "checked": false
          },
          {
            "sight": sights.length + 1,
            "label": "Heater information",
            "type": "panel",
            "image": "",
            "information": "",
            "checked": false
          },
          {
            "sight": sights.length + 1,
            "label": "PowerX setup",
            "type": "panel",
            "image": "",
            "information": "",
            "checked": false
          }
        ]);
        sights.insert(sights.length, {
          "label": "${sights.length + 1}",
          "name": "",
          "address": "",
          "email": "",
          "phone": "",
          "copy": false
        });
        print("widget Added $sights");
      });
    } else {
      setState(() {
        sights.removeAt(index);
        print("widget removed $sights");
      });
    }
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
        itemCount: sights.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 30,
                  decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  // margin: const EdgeInsets.only(bottom: 200),
                  child: Text(
                    sights[index]['label'],
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
                      buttoncall(index);
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
                  child: TextFormField(
                    controller: namecontroller,
                    enabled: !sights[index]['copy'],
                    key: const ValueKey('Name'),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      sights[index]['name'] = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: "Enter name",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.only(left: 22),
                      border: InputBorder.none,
                    ),
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
                  child: TextFormField(
                    controller: addcontroller,
                    enabled: !sights[index]['copy'],
                    key: const ValueKey('Address'),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      sights[index]['address'] = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: "Enter address",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.only(left: 22),
                      border: InputBorder.none,
                    ),
                  ),
                )
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
                  child: TextFormField(
                    controller: emailcontroller,
                    enabled: !sights[index]['copy'],
                    key: const ValueKey('Email'),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      sights[index]['email'] = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: "Enter email",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.only(left: 22),
                      border: InputBorder.none,
                    ),
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
                  child: TextFormField(
                    controller: phonecontroller,
                    enabled: !sights[index]['copy'],
                    key: const ValueKey('Number'),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      sights[index]['phone'] = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Phone number",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.only(left: 22),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ]),
              Container(
                  margin: const EdgeInsets.only(left: 30, top: 100, right: 20),
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
                            value: sights[index]['copy'],
                            onChanged: (value) {
                              setState(() {
                                sights[index]['copy'] = value;
                                if (value == true) {
                                  namecontroller.text = sights[index]['name'] =
                                      CustomerState.name;
                                  addcontroller.text = sights[index]
                                      ['address'] = CustomerState.address;
                                  emailcontroller.text = sights[index]
                                      ['email'] = CustomerState.email;
                                  phonecontroller.text = sights[index]
                                      ['phone'] = CustomerState.number;
                                  print(sights);
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
