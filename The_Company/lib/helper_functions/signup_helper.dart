import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_company/database/models/register_user.dart';
import 'package:the_company/ui_helpers/helper_widgets.dart';
import 'package:the_company/database/firebase_db.dart';

class SignUp {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String varId = '';

  SignUp(this.context);

  BuildContext context;

  Future<void> getOtp(TextEditingController controllerPhone) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91${controllerPhone.text.trim()}',
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            await _auth.signInWithCredential(authCredential);
          },
          verificationFailed: ((error) {
            if (kDebugMode) {
              print("verification Failed error.......... ${error.code}");
            }
            if (error.code == "network-request-failed") {
              MessageDisplay()
                  .showMessage("Check Network Connection!", context);
            } else {
              MessageDisplay().showMessage(error.code.toString(), context);
            }
          }),
          codeSent: (String verificationId, [int? forceResendingToken]) {
            varId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
          },
          timeout: const Duration(seconds: 120));
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
    }
  }

  // check that is user already available or not

  Future<bool> isUserAvailable({required String phone}) async {
    bool isExist = await DatabaseHelper.checkUser(userId: phone);

    if (isExist==true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> validateOtp(String smsCode) async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: varId, smsCode: smsCode);
    bool isVerified =
        await _auth.signInWithCredential(credential).then((result) {
      if (kDebugMode) {
        print('successfully registered');
      }

      MessageDisplay().showMessage("Registered Successfully", context);
      return true;
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    });

    return isVerified;
  }

  Future<void> registerUser(
      String phone, String password, String inviteCode) async {
    var ran =
        "${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";

    UserData userData = UserData(phone, ran, password);

    AccountData accountData = AccountData(null, null, null, null, null);

    WalletData walletData = WalletData(accountData, IncomeData(0), 0);

    WithDrawlData withDrawlData = WithDrawlData(null);

    RegisterUser registerUser = RegisterUser(
        phone, ran, userData, walletData, withDrawlData, inviteCode);

    await DatabaseHelper.registerUser(registerUser: registerUser)
        .then((isSuccessful) {
      if (isSuccessful == true) {
        MessageDisplay().showMessage("Successfully Registered", context);
      } else {
        MessageDisplay().showMessage("Something Went Wrong", context);
      }
    });
  }
}
