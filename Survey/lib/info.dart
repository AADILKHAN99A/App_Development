import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/cstmr.dart';
import 'package:survey/devices.dart';
import 'package:survey/sight.dart';
import 'package:survey/surveylist.dart';
import 'package:survey/widgets/widgets.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => InfoState();
}

class InfoState extends State<Info> with SingleTickerProviderStateMixin {
  //......................Variable and Key Declaration................

  //                                       **-info-**

  final _custformkey = GlobalKey<FormState>();
  final sghtformkey = GlobalKey<FormState>();
  final devformkey = GlobalKey<FormState>();

  var butStatus = 'Next';
  TabController? tabController;

  int count = 1;

  List<bool> tabdisable = [false, true, true];
  List<bool> buttonstatus = [
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
  //                                      **-devices-**
  static List deviceList = [
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

  //                                       **-info-**
  onTap() {
    if (tabdisable[tabController!.index]) {
      int index = tabController!.previousIndex;
      setState(() {
        tabController!.index = index;
      });
    }

    if (buttonstatus[tabController!.index]) {
      setState(() {
        butStatus = 'Submit';
      });
    } else {
      setState(() {
        butStatus = 'Next';
      });
    }
  }

  trysubmit({required GlobalKey<FormState> temp}) {
    final isvalid = temp.currentState?.validate();

    if (isvalid == true) {
      temp.currentState!.save();
      return submitform();
    } else {
      print("Error ");
      return false;
    }
  }

  submitform() {
    print(name);
    print(email);
    print(address);
    print(number);
    return true;
  }

  //                                       **-sight-**

  //                                       **-devices-**

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
                          Form(key: _custformkey, child: const Customer()),
                          Form(key: sghtformkey, child: Sight()),
                          const Devices()
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: button(
                        btnname: butStatus,
                        callback: () {
                          switch (tabController!.index) {
                            case 0:
                              {
                                if (trysubmit(temp: _custformkey)) {
                                  setState(() {
                                    tabController!.index = 1;
                                    tabdisable[tabController!.index] = false;
                                  });
                                  tabController
                                      ?.animateTo(tabController!.index);
                                  print(
                                      "Current tab index : ${tabController!.index}");
                                }
                              }
                              break;
                            case 1:
                              {
                                if (trysubmit(temp: sghtformkey)) {
                                  setState(() {
                                    tabController!.index = 2;
                                    tabdisable[tabController!.index] = false;
                                  });
                                  tabController
                                      ?.animateTo(tabController!.index);
                                  print(
                                      "Current tab index : ${tabController!.index}");

                                  butStatus = 'Submit';
                                }
                              }
                              break;
                            case 2:
                              {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SurveyList()));
                              }
                              break;
                          }
                        }),
                  )
                ])));
  }
}
