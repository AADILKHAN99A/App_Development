import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/widgets/customtextfield.dart';
import 'package:survey/cstmr.dart';

class Sight extends StatefulWidget {
  const Sight({super.key});

  @override
  State<Sight> createState() => sight();
}

class sight extends State<Sight> with AutomaticKeepAliveClientMixin<Sight> {
  //......................Variable and Key Declaration................

  sight? stateObject = context.

  static bool validation = false;

  static List sights = [
    {
      "label": "1",
      "name": "",
      "address": "",
      "email": "",
      "phone": "",
      "copy": false
    }
  ];

  //.....................FUNCTIONS.........................................
  @override
  bool get wantKeepAlive => true;

  ScrollController scrollController = ScrollController();
  scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }


  errorgen(int i)
  {
    setState(() {
      sights[i]['name'] =="" ? validation = true : validation = false;
    });

  }
  static validate() {
    for (int i = 0; i < sights.length; i++) {
      if (sights[i]['name'] == "" ||
          sights[i]['address'] == "" ||
          sights[i]['email'] == "" ||
          sights[i]['phone'] == "") {
        print("error");

        if (sights[i]['name']=="") {
          ;
        }

        // if (sights[i]['address']) {}
        //
        // if (sights[i]['email']) {}
        //
        // if (sights[i]['phone']) {}

        return false;
      }
    }
    print("$sights");
    return true;
  }

  buttoncall(int index) {
    if (index == 0) {
      setState(() {
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
            width: 10,
          );
        },
        itemCount: sights.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    margin: const EdgeInsets.only(left: 180, top: 15),
                    child: Text(
                      sights[index]['label'],
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                      margin:
                      const EdgeInsets.only(top: 15, right: 21, left: 70),
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
                ],
              ),
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
                      onChange: (value) {
                        setState(() {
                          sights[index]["name"] = value;
                        });
                        log("Value: ${sights.toString()}");
                      },
                      hintText: "Enter name",
                      enable: !sights[index]['copy'],
                      errorText: validation ? 'Value Cant Be Empty' : null,
                    )),
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
                      onChange: (value) {
                        setState(() {
                          sights[index]["address"] = value;
                        });
                        log("Value: ${sights.toString()}");
                      },
                      hintText: "Enter address",
                      enable: !sights[index]['copy'],
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
                      onChange: (value) {
                        setState(() {
                          sights[index]["email"] = value;
                        });
                        log("Value: ${sights.toString()}");
                      },
                      hintText: "Enter email",
                      enable: !sights[index]['copy'],
                    )),
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
                      onChange: (value) {
                        setState(() {
                          sights[index]["phone"] = value;
                        });
                        log("Value: ${sights.toString()}");
                      },
                      hintText: "Enter Phone number",
                      enable: !sights[index]['copy'],
                    )),
              ]),
              Container(
                  margin: const EdgeInsets.only(left: 30, top: 110, right: 20),
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
                                  setState(() {
                                    sights[index]['name'] = CustomerState.name;
                                    sights[index]['address'] =
                                        CustomerState.address;
                                    sights[index]['email'] =
                                        CustomerState.email;
                                    sights[index]['phone'] =
                                        CustomerState.number;
                                  });
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
