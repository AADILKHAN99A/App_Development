import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import '../../../database/firebase_database_helper.dart';
import '../../../domain/authentication/firebase_auth.dart';
import '../../../utils/custom_toast.dart';
import '../models/signup_model.dart';

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
