import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:the_taskmanager/common/widgets/snackbar.dart';
import 'package:the_taskmanager/presentation/screens/home/home_screen.dart';
import 'package:the_taskmanager/utils/constants/enums.dart';

import '../../../../data/Models/login_model.dart';
import '../../../../data/repository/database_helper.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  var key = GlobalKey<FormState>();
  RxBool obsecurePassword = true.obs;

  switchLoading() {
    isLoading.value = !isLoading.value;
  }

  var emailController = TextEditingController();
  var passController = TextEditingController();

  validate() {
    if (key.currentState!.validate()) {
      LoginModel model = LoginModel(emailController.text, passController.text);
      signUserIn(model);
    }
  }

  void signUserIn(LoginModel model) async {
    switchLoading();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: model.email.trim(), password: model.password.trim())
          .then((credential) async {
        print("Credentials is $credential");

        final data =
            await FirebaseDatabaseService().getUser(email: model.email);

        if (data != null) {
          CustomSnackBar.showSnackBar(
              title: "Success",
              message: "Welcome",
              type: SnackBarType.completion);
          Get.to(() => HomeScreen(), arguments: [
            {'data': data}
          ]);
        } else {
          CustomSnackBar.showSnackBar(
              title: "Warning",
              message: "Something Wrong!",
              type: SnackBarType.warning);
        }
        switchLoading();
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      switchLoading();

      if (e.code == 'invalid-email') {
        CustomSnackBar.showSnackBar(
            title: "Warning",
            message: "No user found for that email",
            type: SnackBarType.warning);
        if (kDebugMode) {
          print("No user found for that email");
        }
      } else if (e.code == 'invalid-password') {
        CustomSnackBar.showSnackBar(
            title: "Warning",
            message: "User password is Incorrect",
            type: SnackBarType.warning);
      } else if (e.code == 'invalid-credential') {
        CustomSnackBar.showSnackBar(
            title: "Warning",
            message: "User Credentials is Invalid",
            type: SnackBarType.warning);
      } else if (e.code == 'too-many-requests') {
        CustomSnackBar.showSnackBar(
            title: "Warning",
            message: "Account is Temporarily disable due to too many attempts",
            type: SnackBarType.warning);
      } else if (e.code == 'user-not-found') {
        CustomSnackBar.showSnackBar(
            title: "Warning",
            message: "User is not found,Please Create Account",
            type: SnackBarType.warning);
      }
    }
  }
}
