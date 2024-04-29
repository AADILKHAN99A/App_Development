import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_company/database/firebase_db.dart';
import 'package:the_company/ui_helpers/helper_widgets.dart';
import '../controllers/login_controller.dart';

class Login {
  final BuildContext context;

  final LoginController controller;

  final String phone;
  final String password;

  Login(
      {required this.context,
      required this.controller,
      required this.phone,
      required this.password});

  loginUser() async {
    MessageDisplay().showMessage("Please wait....", context);

    controller.updateLoading(true);

    await DatabaseHelper.readUserData(userId: phone).then((userData) {
      // user data received
      if (userData != null) {
        // password is correct
        if (userData.password == password) {
          MessageDisplay().showMessage("Welcome", context);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>))
        }
        // password is not correct
        else {
          MessageDisplay().showMessage("Incorrect Password!", context);
        }
      }
      // user data not received
      else {
        MessageDisplay().showMessage("User not Registered", context);
      }

      controller.updateLoading(false);
    }).onError((error, stackTrace) {
      MessageDisplay().showMessage(error.toString(), context);
    });
  }
}
