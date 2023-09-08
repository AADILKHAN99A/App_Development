import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/customer.dart';
import 'package:survey/database_helper.dart';
import 'package:survey/datamodels.dart';
import 'package:survey/devices.dart';
import 'package:survey/sight.dart';
import 'package:survey/survey_list.dart';
import 'package:survey/widgets/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Info extends StatefulWidget {
  const Info({super.key, required this.refresh});
  final VoidCallback refresh;
  @override
  State<Info> createState() => InfoState();
}

class InfoState extends State<Info> with SingleTickerProviderStateMixin {
  //......................Variable and Key Declaration................
  FToast? fToast;
  final dbHelper = DatabaseHelper.instance;
  static int checkValue = 0;

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

  static Map<String, dynamic> customerDetails = {
    "name": "",
    "address": "",
    "email": "",
    "phone": "",
    "dateTime": ""
  };

  //                                       **-sight-**

  static bool validate = false;

  static List sights = [
    {
      "label": "Sight 1",
      "name": "",
      "address": "",
      "email": "",
      "phone": "",
      "checked": false,
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
    fToast = FToast();
    fToast?.init(context);
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.addListener(() {
      onTap();
    });
  }

  showCustomToast() {
    Widget toast = Container(
      margin: const EdgeInsets.only(bottom: 35),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black.withOpacity(0.30000000074505806),
      ),
      child: const Text(
        "Select Atleast one",
        style: TextStyle(color: Colors.white),
      ),
    );

    fToast?.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
    );
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
      print(customerDetails['name']);
    }
    if (kDebugMode) {
      print(customerDetails['email']);
    }
    if (kDebugMode) {
      print(customerDetails['address']);
    }
    if (kDebugMode) {
      print(customerDetails['phone']);
    }
    return true;
  }

//...........................**-Database Query Functions-**.....................
  void insertData(Map<String, dynamic> customerData, data) async {
    final id = await dbHelper.insert(row: customerData, table: customerTable);
    print(id);
    int deviceId;
    int sightId;
    for (int i = 0; i < data.length; i++) {
      sightId =
          await dbHelper.insert(row: data[i], table: sightTable, tempId: id);
      for (int j = 0; j < data[i]['devices'].length; j++) {
        deviceId = await dbHelper.insert(
            row: data[i]['devices'][j], table: deviceTable, tempId: sightId);
        print("Device ID $deviceId");
      }
      print("Sight ID $sightId");
    }
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
                                if (tabDisable[2] == false) {
                                  setState(() {
                                    tabController!.index = 2;
                                    butStatus = 'Submit';
                                    tabController
                                        ?.animateTo(tabController!.index);
                                  });
                                }
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
                                if (trySubmit(temp: customerFormKey)) {
                                  if (trySubmit(temp: sightFormKey)) {
                                    if (checkValue > 0) {
                                      if (trySubmit(temp: devFormKey)) {
                                        if (kDebugMode) {
                                          print(sights.toString());
                                        }
                                        var time = DateTime.now();
                                        customerDetails['dateTime'] =
                                            DateFormat.d()
                                                .add_yMMM()
                                                .add_jm()
                                                .format(time);

                                        insertData(customerDetails, sights);
                                        widget.refresh;
                                        setState(() {
                                          customerDetails = {
                                            "name": "",
                                            "address": "",
                                            "email": "",
                                            "phone": "",
                                            "dateTime": ""
                                          };
                                          sights = [
                                            {
                                              "label": "Sight 1",
                                              "name": "",
                                              "address": "",
                                              "email": "",
                                              "phone": "",
                                              "checked": false,
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
                                        });
                                        Navigator.pop(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SurveyList()));
                                      } else {
                                        if (kDebugMode) {
                                          print("Error");
                                        }
                                      }
                                    } else {
                                      print(checkValue);
                                      showCustomToast();
                                    }
                                  } else {
                                    setState(() {
                                      tabController!.index = 1;
                                    });
                                    butStatus = 'Next';
                                    tabController
                                        ?.animateTo(tabController!.index);
                                  }
                                } else {
                                  setState(() {
                                    tabController!.index = 0;
                                  });
                                  butStatus = 'Next';
                                  tabController
                                      ?.animateTo(tabController!.index);
                                }
                              }
                              break;
                          }
                        }),
                  )
                ])));
  }
}
