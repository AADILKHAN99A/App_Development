import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_company/presentation/login_screen/models/login_model.dart';

import '../../../database/firebase_db.dart';
import '../../../widgets/helper_widgets.dart';
import '../../init_screen/init_page.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  // loading in ui
  final _isLoading = false.obs;

  RxBool get isLoading => _isLoading;

  void updateLoading(var isLoading) {
    _isLoading.value = isLoading;
  }

  // hide password
  final RxBool _visiblePassword = false.obs;

  RxBool get visiblePassword => _visiblePassword;

  void updateVisiblePassword(bool value) {
    _visiblePassword.value = value;
  }

  loginUser(BuildContext context, LoginModel model) async {
    MessageDisplay().showMessage("Please wait....", context);

    updateLoading(true);

    await DatabaseHelper.readUserData(userId: model.phone)
        .then((userData) async {
      // user data received
      if (userData != null) {
        // password is correct
        if (userData.password == model.password) {
          MessageDisplay().showMessage("Welcome", context);

          updateLoading(false);

          // navigate to init page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) =>
                      InitPage(args: {'userData': userData})));
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

      updateLoading(false);
    }).onError((error, stackTrace) {
      MessageDisplay().showMessage(error.toString(), context);
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
