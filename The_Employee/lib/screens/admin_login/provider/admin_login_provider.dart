import 'package:flutter/Material.dart';
import 'package:the_employee/database/database_helper.dart';
import 'package:the_employee/routes/app_routes.dart';
import 'package:the_employee/screens/admin_login/models/admin_login_model.dart';
import 'package:the_employee/utils/custom_toast.dart';

class AdminLoginProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> adminLogin(AdminLoginModel model, BuildContext context,AdminLoginProvider provider) async {
    provider.setLoading(true);
    final res = await FirebaseDatabaseService().checkAdmin(model: model);

    if (res != null) {
      if (res.password == model.password) {
        commonToast("Welcome Admin");
        provider.setLoading(false);
        Navigator.pushNamed(context, RouteName.adminPanelScreen);
      } else {
        commonToast("Wrong Password");
      }
    } else {
      commonToast("Something Wrong");
    }
    provider.setLoading(false);
  }
}
