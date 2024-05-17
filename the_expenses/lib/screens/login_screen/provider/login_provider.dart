import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:the_expenses/database/database_helper.dart';
import '../../../domain/authentication/firebase_auth.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_toast.dart';
import '../../signup_screen/models/signup_model.dart';
import '../models/login_model.dart';

class LogInProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

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
        SignUpModel? model =
            await databaseHelper.fetchUser(userId: credential.user.uid);

        // if user doesn't exist in database
        if (model == null) {
          SignUpModel signUpModel = SignUpModel(
              userId: credential.user.uid,
              name: (credential).user.displayName.toString(),
              email: (credential).user.email.toString(),
              phone: (credential).user.phoneNumber.toString(),
              password: '');

          // insert user in Database

          model = await databaseHelper.insertUser(model: signUpModel);
        }

        commonToast('Login Successfully');
        Navigator.pushNamed(context, RouteName.homeScreen,
            arguments: {'data': model});
      }
    });
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
        // fetch user details from Database
        SignUpModel? signUpModel =
            await databaseHelper.fetchUser(userId: credential.user?.uid);

        // user exist in Database
        if (signUpModel != null) {
          commonToast("Welcome");

          Navigator.pushNamed(context, RouteName.homeScreen,
              arguments: {'data': signUpModel});
        }
        // user doesn't exist in Database
        else {
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
