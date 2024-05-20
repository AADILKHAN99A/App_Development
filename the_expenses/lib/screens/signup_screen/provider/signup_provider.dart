import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:the_expenses/database/database_helper.dart';
import 'package:the_expenses/routes/routes.dart';
import '../../../domain/authentication/firebase_auth.dart';
import '../../../utils/custom_toast.dart';
import '../models/signup_model.dart';

class SignUpProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  Future userSignUp(
      SignUpModel model, SignUpProvider provider, BuildContext context) async {
    provider.setLoading(true);

    // signup user
    var user =
        await _auth.signUpWithEmailPassword(model.email, model.password!);

    if (user != null) {
      // add userid into object
      model = model.copy(userId: user.uid);

      // insert user into database and receive object with id added
      model = await databaseHelper.insertUser(model: model);

      commonToast("Registered Successfully");
      provider.setLoading(false);

      Navigator.pushReplacementNamed(context, RouteName.homeScreen,
          arguments: {'data': model, 'notify': true});
    } else {
      if (kDebugMode) {
        print("Some error happened");
      }
    }

    provider.setLoading(false);
  }
}
