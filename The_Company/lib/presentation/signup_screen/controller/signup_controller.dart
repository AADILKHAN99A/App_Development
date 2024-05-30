import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:the_company/presentation/signup_screen/models/signup_model.dart';

import '../../../database/firebase_db.dart';
import '../../../database/models/register_user.dart';
import '../../../widgets/helper_widgets.dart';

class SignUpController extends GetxController {
  // loading in ui
  final RxBool _isLoading = false.obs;

  RxBool get isLoading => _isLoading;

  void updateLoading(var isLoading) {
    _isLoading.value = isLoading;
  }

  // otp button loading

  final RxBool _isOtpLoading = false.obs;

  RxBool get isOtpLoading => _isOtpLoading;

  void updateOtpLoading(var isOtpLoading) {
    _isOtpLoading.value = isOtpLoading;
  }

  // hide password
  final RxBool _visiblePassword = false.obs;

  RxBool get visiblePassword => _visiblePassword;

  void updateVisiblePassword(bool value) {
    _visiblePassword.value = value;
  }

  // hide confirm password
  final RxBool _visibleConfirmPassword = false.obs;

  RxBool get visibleConfirmPassword => _visibleConfirmPassword;

  void updateVisibleConfirmPassword(bool value) {
    _visibleConfirmPassword.value = value;
  }

  // hide confirm password
  final RxBool _checkedTAC = false.obs;

  RxBool get checkedTAC => _checkedTAC;

  void updateCheckedTAC(bool value) {
    _checkedTAC.value = value;
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  String varId = '';

  Future<void> getOtp(String phone, BuildContext context) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91${phone.trim()}',
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
            MessageDisplay().showMessage("Code Sent Successfully", context);
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

    if (isExist == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> validateOtp(String smsCode, BuildContext context) async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: varId, smsCode: smsCode);
    bool isVerified =
        await _auth.signInWithCredential(credential).then((result) {
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

  Future<void> registerUser(SignupModel model, BuildContext context) async {
    var ran =
        "${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";

    UserData userData = UserData(model.phone, ran, model.password!);

    AccountData accountData = AccountData(null, null, null, null, null);

    WalletData walletData = WalletData(accountData, IncomeData(0), 0);

    WithDrawlData withDrawlData = WithDrawlData(null);

    RegisterUser registerUser = RegisterUser(model.phone, ran, userData,
        walletData, withDrawlData, model.inviteCode!);

    await DatabaseHelper.registerUser(registerUser: registerUser)
        .then((isSuccessful) {
      if (isSuccessful == true) {
        MessageDisplay().showMessage("Successfully Registered", context);
      } else {
        MessageDisplay().showMessage("Something Went Wrong", context);
      }
    });
  }

  void initGetOtpFeature(SignupModel model, BuildContext context) async {
    // check that user is already available or not
    updateOtpLoading(true);
    await isUserAvailable(phone: model.phone).then((available) async {
      // user is not registered
      if (available != true) {
        await getOtp(model.phone, context);
      }

      // user is already registered
      else {
        MessageDisplay().showMessage("User Already Registered", context);
      }
      updateOtpLoading(false);
    });
  }

  void initVerifiedOtpFeature(SignupModel model, BuildContext context) async {
    MessageDisplay().showMessage("Please wait...", context);

    updateLoading(true);

    // validate otp and check status of verified or not
    bool isVerified = await validateOtp(model.sms!, context);

    if (isVerified == true) {
      await registerUser(model, context);
      updateLoading(false);
      Get.offAndToNamed('login');
    }
    updateLoading(false);
  }
}
