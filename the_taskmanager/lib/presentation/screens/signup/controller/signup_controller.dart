import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:the_taskmanager/common/widgets/snackbar.dart';
import 'package:the_taskmanager/utils/constants/enums.dart';

import '../../../../data/Models/signup_model.dart';
import '../../../../data/repository/database_helper.dart';
import '../../../../data/services/authentication/firebase_auth.dart';
import '../../home/home_screen.dart';

class SignupController extends GetxController {
  var passwordVisible = true.obs;
  var confirmPasswordVisible = true.obs;
  final formKey = GlobalKey<FormState>();

  switchLoading() {
    isLoading.value = !isLoading.value;
  }

  var isLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  validate() async {
    switchLoading();
    if (formKey.currentState!.validate()) {
      final SignUpModel model = SignUpModel(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          password: passwordController.text);

      await userSignUp(model).then((result) {
        if (result) {
          Get.off(() => HomeScreen(), arguments: [
            {'data': model}
          ]);
        }
      });
    }
    switchLoading();
  }

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  Future<bool> userSignUp(SignUpModel model) async {
    var user = await _auth.signUpWithEmailPassword(model.email, model.password);

    if (user != null) {
      String res = await FirebaseDatabaseService().addUser(signUpModel: model);

      if (res.contains('success')) {
        CustomSnackBar.showSnackBar(
            title: "Success",
            message: "Successfully Registered",
            type: SnackBarType.completion);

        return true;
      }
    } else {
      if (kDebugMode) {
        print("Some error happened");
      }
    }

    return false;
  }
}
