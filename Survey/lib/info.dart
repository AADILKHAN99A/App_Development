import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/customer.dart';
import 'package:survey/devices.dart';
import 'package:survey/sight.dart';
import 'package:survey/survey_list.dart';
import 'package:survey/widgets/widgets.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => InfoState();
}

class InfoState extends State<Info> with SingleTickerProviderStateMixin {
  //......................Variable and Key Declaration................

  //                                       **-info-**

  final customerFormKey = GlobalKey<FormState>();
  final sightFormKey = GlobalKey<FormState>();
  final devFormKey = GlobalKey<FormState>();

  var butStatus = 'Next';
  TabController? tabController;

  int count = 1;

  List<bool> tabDisable = [false, true, true];
  List<bool> buttonStatus = [
    false,
    false,
    true
  ]; // false = next , true = submit

  //                                       **-cstmr-**
  static String name = '';

  static String address = '';

  static String email = '';

  static String number = '';

  //                                       **-sight-**

  static bool validate = false;

  static List sights = [
    {
      "label": "Sight 1",
      "name": "",
      "address": "",
      "email": "",
      "phone": "",
      "check": false,
      "devices": [
        {
          "sight": "Sight 1",
          "label": "Panel information",
          "type": "panel",
          "image": "",
          "information": "",
          "checked": false
        },
        {
          "sight": "Sight 1",
          "label": "AC",
          "type": "panel",
          "image": "",
          "information": "",
          "checked": false
        },
        {
          "sight": "Sight 1",
          "label": "Heater information",
          "type": "panel",
          "image": "",
          "information": "",
          "checked": false
        },
        {
          "sight": "Sight 1",
          "label": "PowerX setup",
          "type": "panel",
          "image": "",
          "information": "",
          "checked": false
        },
      ]
    }
  ];

  //..............................FUNCTIONS.....................................

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.addListener(() {
      onTap();
    });
  }

  onTap() {
    if (tabDisable[tabController!.index]) {
      int index = tabController!.previousIndex;
      setState(() {
        tabController!.index = index;
      });
    }

    if (buttonStatus[tabController!.index]) {
      setState(() {
        butStatus = 'Submit';
      });
    } else {
      setState(() {
        butStatus = 'Next';
      });
    }
  }

  trySubmit({required GlobalKey<FormState> temp}) {
    final isValid = temp.currentState?.validate();

    if (isValid == true) {
      temp.currentState!.save();
      return submitForm();
    } else {
      if (kDebugMode) {
        print("Error ");
      }
      return false;
    }
  }

  submitForm() {
    if (kDebugMode) {
      print(name);
    }
    if (kDebugMode) {
      print(email);
    }
    if (kDebugMode) {
      print(address);
    }
    if (kDebugMode) {
      print(number);
    }
    return true;
  }

//..................................Information Page.............................

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    // color: Colors.purple,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 60),
                    child: Text(
                      "Information",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.53),
                    ),
                  ),
                  Container(
                    height: 39,
                    margin: const EdgeInsets.only(top: 18, left: 20, right: 20),
                    decoration: ShapeDecoration(
                        color: Colors.black.withOpacity(0.05000000074505806),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: TabBar(
                        onTap: (int index) => onTap(),
                        controller: tabController,
                        unselectedLabelColor:
                            Colors.black.withOpacity(0.6000000238418579),
                        labelColor: Colors.white,
                        indicatorColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black),
                        tabs: [
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.brown,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Customer",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.brown,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Sight",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.brown,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Devices",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: [
                          Form(key: customerFormKey, child: const Customer()),
                          Form(
                            key: sightFormKey,
                            child: Sight(
                              voidcallback: () {
                                setState(() {
                                  tabController!.index = 2;
                                  butStatus = 'Submit';
                                  tabController
                                      ?.animateTo(tabController!.index);
                                });
                              },
                            ),
                          ),
                          Form(key: devFormKey, child: Devices())
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Button(
                        btnName: butStatus,
                        callback: () {
                          switch (tabController!.index) {
                            case 0:
                              {
                                if (trySubmit(temp: customerFormKey)) {
                                  setState(() {
                                    tabController!.index = 1;
                                    tabDisable[tabController!.index] = false;
                                  });
                                  tabController
                                      ?.animateTo(tabController!.index);
                                  if (kDebugMode) {
                                    print(
                                        "Current tab index : ${tabController!.index}");
                                  }
                                }
                              }
                              break;
                            case 1:
                              {
                                if (trySubmit(temp: sightFormKey)) {
                                  setState(() {
                                    tabController!.index = 2;
                                    tabDisable[tabController!.index] = false;
                                  });
                                  tabController
                                      ?.animateTo(tabController!.index);
                                  if (kDebugMode) {
                                    print(
                                        "Current tab index : ${tabController!.index}");
                                  }

                                  butStatus = 'Submit';
                                }
                              }
                              break;
                            case 2:
                              {
                                if (trySubmit(temp: devFormKey)) {
                                  if (kDebugMode) {
                                    print(sights.toString());
                                  }
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SurveyList()));
                                }
                              }
                              break;
                          }
                        }),
                  )
                ])));
  }
}
