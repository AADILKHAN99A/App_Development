import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:the_employee/screens/signup_screen/models/signup_model.dart';
import 'package:the_employee/utils/custom_toast.dart';

import '../../../database/database_helper.dart';
import '../../../domain/authentication/firebase_auth.dart';

class SignUpProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  Future<bool> userSignUp(SignUpModel model,SignUpProvider provider) async {
    provider.setLoading(true);
    var user = await _auth.signUpWithEmailPassword(model.email, model.password);

    if (user != null) {
      String res = await FirebaseDatabaseService()
          .addUser(signUpModel: model, uid: user.uid);

      if (res.contains('success')) {
        commonToast("Registered Successfully");
        provider.setLoading(false);

        return true;
      }
    } else {
      if (kDebugMode) {
        print("Some error happened");
      }

    }

    provider.setLoading(false);

    return false;
  }
}
