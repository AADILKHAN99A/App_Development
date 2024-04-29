import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portfolio/database/firestore_helper.dart';
import 'package:portfolio/responsive/responsive_layout.dart';

class Message {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _subjectKey = GlobalKey<FormFieldState>();
  final _messageKey = GlobalKey<FormFieldState>();

  bool isExpand = true;

  void showMessage(BuildContext context, String message) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      maxWidth: MediaQuery.of(context).size.width / 3,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.transparent,
    ));
  }

  validate(BuildContext context) async {
    if (_nameKey.currentState!.validate() &&
        _emailKey.currentState!.validate() &&
        _subjectKey.currentState!.validate() &&
        _messageKey.currentState!.validate()) {
      await FireStoreHelper()
          .writeEntry(
              name: nameController.text.toString(),
              email: emailController.text.toString(),
              subject: subjectController.text.toString(),
              message: messageController.text.toString())
          .then((value) => showMessage(context, "Send Successfully"));

      disposeControllers();
    }
  }

  showPopUpMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ResponsiveLayout(
            mobileBody(context),
            desktopBody(context),
            width: 988,
          );
        });
  }

  Widget desktopBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(150),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                width: 800,
                height: 800,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: const Row(children: [
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text("Jaipur ,Rajasthan,IN"),
                                )
                              ]),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(children: [
                                const Icon(Icons.dialer_sip,
                                    color: Colors.white),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(const ClipboardData(
                                            text: "+918114462733"))
                                        .then((value) => showMessage(
                                            context, "Copied to Clipboard"));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text("Phone: +918114462733"),
                                  ),
                                )
                              ]),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(children: [
                                const Icon(Icons.mail, color: Colors.white),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(const ClipboardData(
                                            text: "aadilkhan99a@gmail.com"))
                                        .then((value) => showMessage(
                                            context, "Copied to Clipboard"));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child:
                                        Text("Email: aadilkhan99a@gmail.com"),
                                  ),
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Form(
                        key: key,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  controller: nameController,
                                  key: _nameKey,
                                  decoration: InputDecoration(
                                      hintText: "Name",
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      errorStyle:
                                          TextStyle(color: Colors.grey)),
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Please fill out this field";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  key: _emailKey,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      errorStyle:
                                          TextStyle(color: Colors.grey)),
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Please fill out this field";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  key: _subjectKey,
                                  controller: subjectController,
                                  decoration: InputDecoration(
                                      hintText: "Subject",
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      errorStyle:
                                          TextStyle(color: Colors.grey)),
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Please fill out this field";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  key: _messageKey,
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      hintText: "Message",
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      errorStyle:
                                          TextStyle(color: Colors.grey)),
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Please fill out this field";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    side:
                                        const BorderSide(color: Colors.white)),
                                onPressed: () {
                                  validate(context);
                                },
                                icon: const ImageIcon(
                                  AssetImage("assets/send_icon.png"),
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  "Send",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mobileBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: (MediaQuery.of(context).size.height / 6).floorToDouble()),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                width: 350,
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: const Row(children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text("Jaipur ,Rajasthan,IN"),
                                  )
                                ]),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Row(children: [
                                  const Icon(Icons.dialer_sip,
                                      color: Colors.white),
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(const ClipboardData(
                                              text: "+918114462733"))
                                          .then((value) => showMessage(
                                              context, "Copied to Clipboard"));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text("Phone: +918114462733"),
                                    ),
                                  )
                                ]),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Row(children: [
                                  const Icon(Icons.mail, color: Colors.white),
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(const ClipboardData(
                                              text: "aadilkhan99a@gmail.com"))
                                          .then((value) => showMessage(
                                              context, "Copied to Clipboard"));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child:
                                          Text("Email: aadilkhan99a@gmail.com"),
                                    ),
                                  )
                                ]),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Form(
                            key: key,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                      controller: nameController,
                                      key: _nameKey,
                                      decoration: InputDecoration(
                                          hintText: "Name",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius: BorderRadius
                                                      .circular(10)),
                                          errorStyle:
                                              TextStyle(color: Colors.grey)),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Please fill out this field";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                      key: _emailKey,
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius: BorderRadius
                                                      .circular(10)),
                                          errorStyle:
                                              TextStyle(color: Colors.grey)),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Please fill out this field";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                      key: _subjectKey,
                                      controller: subjectController,
                                      decoration: InputDecoration(
                                          hintText: "Subject",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius: BorderRadius
                                                      .circular(10)),
                                          errorStyle:
                                              TextStyle(color: Colors.grey)),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Please fill out this field";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                      key: _messageKey,
                                      controller: messageController,
                                      decoration: InputDecoration(
                                          hintText: "Message",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white),
                                                  borderRadius: BorderRadius
                                                      .circular(10)),
                                          errorStyle:
                                              TextStyle(color: Colors.grey)),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Please fill out this field";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        side: const BorderSide(
                                            color: Colors.white)),
                                    onPressed: () {
                                      validate(context);
                                    },
                                    icon: ImageIcon(
                                      AssetImage("assets/send_icon.png"),
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      "Send",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void disposeControllers() {
    nameController.clear();
    subjectController.clear();
    emailController.clear();
    messageController.clear();
  }
}
