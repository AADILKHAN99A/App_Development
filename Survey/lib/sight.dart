import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/info.dart';
import 'package:survey/widgets/customTextFormField.dart';
import 'package:email_validator/email_validator.dart';

class Sight extends StatefulWidget {
  Sight({super.key, required this.voidcallback, required this.sightkey});
  final GlobalKey<FormState> sightkey;
  final VoidCallback voidcallback;

  @override
  State<Sight> createState() => SightState();
}

class SightState extends State<Sight>
    with AutomaticKeepAliveClientMixin<Sight> {
  //......................Variable Declaration................

  static int display = 0;
  //.....................FUNCTIONS.........................................
  @override
  bool get wantKeepAlive => true;
  ScrollController scrollController = ScrollController();
  scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  sightButtonCall(index) {
    if (index == 0) {
      setState(() {
        InfoState.sights.insert(InfoState.sights.length, {
          "label": "Sight ${InfoState.sights.length + 1}",
          "name": "",
          "address": "",
          "email": "",
          "phone": "",
          "checked": false,
          "devices": [
            {
              "sight": "Sight ${InfoState.sights.length + 1}",
              "label": "Panel information",
              "type": "panel",
              "image": "",
              "information": "",
              "checked": false
            },
            {
              "sight": "Sight ${InfoState.sights.length + 1}",
              "label": "AC",
              "type": "panel",
              "image": "",
              "information": "",
              "checked": false
            },
            {
              "sight": "Sight ${InfoState.sights.length + 1}",
              "label": "Heater information",
              "type": "panel",
              "image": "",
              "information": "",
              "checked": false
            },
            {
              "sight": "Sight ${InfoState.sights.length + 1}",
              "label": "PowerX setup",
              "type": "panel",
              "image": "",
              "information": "",
              "checked": false
            }
          ]
        });
        if (kDebugMode) {
          print("widget Added ${InfoState.sights}");
        }
      });
    } else {
      display = index - 1;
      setState(() {
        InfoState.sights.removeAt(index);
        if (kDebugMode) {
          print("widget removed ${InfoState.sights}");
        }
      });
    }
  }

//...................................Sight Page.................................
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: widget.sightkey,
      child: ListView.separated(
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
                        sightButtonCall(index);
                        if (kDebugMode) {
                          print(InfoState.sights[0]['devices'].length);
                        }
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) => scrollToBottom());
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
                    child: CustomTextFormField(
                      onChange: (value) {
                        InfoState.sights[index]['name'] = value.toString();
                      },
                      enable: !InfoState.sights[index]['checked'],
                      hintText: "Enter name",
                      copyData: InfoState.customerDetails['name'],
                      keyboardType: "name",
                      valueKey: const ValueKey('name'),
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Required';
                        } else if (value.toString().length < 2) {
                          return 'Name is too small';
                        } else {
                          return null;
                        }
                      },
                    ),
                  )
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
                      child: CustomTextFormField(
                        onChange: (value) {
                          InfoState.sights[index]['address'] = value.toString();
                        },
                        enable: !InfoState.sights[index]['checked'],
                        hintText: "Enter address",
                        copyData: InfoState.customerDetails['address'],
                        keyboardType: "address",
                        valueKey: const ValueKey('address'),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Required';
                          } else {
                            return null;
                          }
                        },
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
                    child: CustomTextFormField(
                      onChange: (value) {
                        InfoState.sights[index]['email'] = value.toString();
                      },
                      enable: !InfoState.sights[index]['checked'],
                      hintText: "Enter email",
                      copyData: InfoState.customerDetails['email'],
                      keyboardType: "email",
                      valueKey: const ValueKey('email'),
                      validator: (value) {
                        if (EmailValidator.validate(value)) {
                          return null;
                        } else if (value.toString().isEmpty) {
                          return 'Required';
                        } else {
                          return 'Enter Valid Email';
                        }
                      },
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
                      child: CustomTextFormField(
                        onChange: (value) {
                          InfoState.sights[index]['phone'] = value.toString();
                        },
                        enable: !InfoState.sights[index]['checked'],
                        hintText: "Enter Phone number",
                        copyData: InfoState.customerDetails['phone'],
                        keyboardType: "phone",
                        valueKey: const ValueKey('phone'),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Required';
                          } else if (!RegExp(
                                  r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                              .hasMatch(value!)) {
                            return "Enter Valid Mobile Number";
                          }
                          return null;
                        },
                      )),
                ]),
                Container(
                  height: 22,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, left: 250),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        display = index;
                        widget.voidcallback();
                      });
                      if (kDebugMode) {
                        print(InfoState.sights);
                      }
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
                              value: InfoState.sights[index]['checked'],
                              onChanged: (value) {
                                setState(() {
                                  InfoState.sights[index]['checked'] = value;
                                  if (value == true) {
                                    InfoState.sights[index]['name'] =
                                        InfoState.customerDetails['name'];
                                    InfoState.sights[index]['address'] =
                                        InfoState.customerDetails['address'];
                                    InfoState.sights[index]['email'] =
                                        InfoState.customerDetails['email'];
                                    InfoState.sights[index]['phone'] =
                                        InfoState.customerDetails['phone'];
                                    if (kDebugMode) {
                                      print(InfoState.sights);
                                    }
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
          }),
    );
  }
}
