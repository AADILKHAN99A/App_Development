import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/cstmr.dart';

class Sight extends StatefulWidget {
  const Sight({super.key});

  @override
  State<Sight> createState() => sight();
}

class sight extends State<Sight> with AutomaticKeepAliveClientMixin<Sight> {
  //......................Variable and Key Declaration................
  List sights = [
    {"lable": "Sight1", "name": "", "address": "", "email": "", "phone": "","copy":false}
  ];
  String sightName = '';
  String sightAddress = '';
  String sightEmail = '';
  String sightNumber = '';
  List<bool> chkboxvaluelist = [true];
  List<TextEditingController> namecontrollerlist = [TextEditingController()];
  List<TextEditingController> addcontrollerlist = [TextEditingController()];
  List<TextEditingController> emailcontrollerlist = [TextEditingController()];
  List<TextEditingController> phonecontrollerlist = [TextEditingController()];

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
        namecontrollerlist.add(TextEditingController());
        addcontrollerlist.add(TextEditingController());
        emailcontrollerlist.add(TextEditingController());
        phonecontrollerlist.add(TextEditingController());
        chkboxvaluelist.add(true);
      });
    } else {
      setState(() {
        namecontrollerlist[index].clear();
        namecontrollerlist[index].dispose();
        namecontrollerlist.removeAt(index);

        addcontrollerlist[index].clear();
        addcontrollerlist[index].dispose();
        addcontrollerlist.removeAt(index);

        emailcontrollerlist[index].clear();
        emailcontrollerlist[index].dispose();
        emailcontrollerlist.removeAt(index);

        phonecontrollerlist[index].clear();
        phonecontrollerlist[index].dispose();
        phonecontrollerlist.removeAt(index);

        chkboxvaluelist.removeAt(index);
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
        itemCount: namecontrollerlist.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 15, right: 21, left: 280),
                  height: 35,
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
                    controller: namecontrollerlist[index],
                    enabled: chkboxvaluelist[index],
                    key: const ValueKey('Name'),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      sightName = value.toString();
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
                    controller: addcontrollerlist[index],
                    enabled: chkboxvaluelist[index],
                    key: const ValueKey('Address'),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      sightAddress = value.toString();
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
                    controller: emailcontrollerlist[index],
                    enabled: chkboxvaluelist[index],
                    key: const ValueKey('Email'),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      sightEmail = value.toString();
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
                    controller: phonecontrollerlist[index],
                    enabled: chkboxvaluelist[index],
                    key: const ValueKey('Number'),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      sightNumber = value.toString();
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
                            value: !chkboxvaluelist[index],
                            onChanged: (value) {
                              setState(() {
                                chkboxvaluelist[index] =
                                !chkboxvaluelist[index];
                                if (value == true) {
                                  namecontrollerlist[index].text =
                                      sightName = CustomerState.name;
                                  addcontrollerlist[index].text =
                                      sightAddress = CustomerState.address;
                                  emailcontrollerlist[index].text =
                                      sightEmail = CustomerState.email;
                                  phonecontrollerlist[index].text =
                                      sightNumber = CustomerState.number;
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