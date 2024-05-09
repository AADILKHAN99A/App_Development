import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:the_employee/routes/app_routes.dart';
import 'package:the_employee/screens/login_screen/models/login_model.dart';
import 'package:the_employee/screens/signup_screen/models/signup_model.dart';
import 'package:the_employee/utils/custom_toast.dart';

import '../../../database/database_helper.dart';
import '../../../domain/authentication/firebase_auth.dart';

class LogInProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  setLoading(bool value) {
    _isLoading = value;
    print(_isLoading);
    notifyListeners();
  }

  void userGoogleLogIn(BuildContext context) async {
    await FirebaseAuthServices().signInWithGoogle().then((credential) async {
      // print(credential);
      if (credential != null) {
        var data = await FirebaseDatabaseService()
            .getUser(email: (credential).user.email);

        if (data == null) {
          SignUpModel model = SignUpModel(
              name: (credential).user.displayName.toString(),
              email: (credential).user.email.toString(),
              phone: (credential).user.phoneNumber.toString(),
              password: '');
          final res = await FirebaseDatabaseService()
              .addUser(signUpModel: model, uid: (credential).user.uid);

          if (res.contains('success')) {
            commonToast("Login Successfully");
          }
        } else {
          commonToast('Login Successfully');
        }
        await checkData((credential).user.email.toString(), context);
      }
    });
  }

  Future<void> checkData(
      final String primaryEmail, BuildContext context) async {
    final res = await FirebaseDatabaseService()
        .getUserDetails(primaryEmail: primaryEmail);
    setLoading(false);
    if (res != null) {
      Navigator.pushNamed(context, RouteName.employeeDataScreen,
          arguments: {'data': res, 'primaryEmail': primaryEmail});
    } else {
      Navigator.pushNamed(context, RouteName.homeScreen,
          arguments: {'id': primaryEmail});
    }
  }

  void signUserIn(
      LoginModel model, BuildContext context, LogInProvider provider) async {
    provider.setLoading(true);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: model.email.trim(), password: model.password.trim())
          .then((credential) async {
        print("Credentials is $credential");

        final data =
            await FirebaseDatabaseService().getUser(email: model.email);
        if (data != null) {
          commonToast("Welcome");
          checkData(model.email.toString(), context);
        } else {
          commonToast("Something wrong");
        }
        provider.setLoading(false);
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      provider.setLoading(false);

      if (e.code == 'invalid-email') {
        commonToast("No user found for that email");
        if (kDebugMode) {
          print("No user found for that email");
        }
      } else if (e.code == 'invalid-password') {
        commonToast("User password is Incorrect");
        if (kDebugMode) {
          print("User password is Incorrect");
        }
      } else if (e.code == 'invalid-credential') {
        commonToast("User Credentials is Invalid");
        if (kDebugMode) {
          print("User Credentials is Invalid");
        }
      } else if (e.code == 'too-many-requests') {
        commonToast("Account is Temporarily disable due to too many attempts");
        if (kDebugMode) {
          print("Account is Temporarily disable due to too many attempts");
        }
      } else if (e.code == 'user-not-found') {
        commonToast("User is not found,Please Create Account");
        if (kDebugMode) {
          print("User Not found");
        }
      }
    }
  }
}
