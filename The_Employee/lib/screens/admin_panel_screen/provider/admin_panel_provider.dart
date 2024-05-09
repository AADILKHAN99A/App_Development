import 'package:flutter/Material.dart';
import 'package:the_employee/database/database_helper.dart';
import 'package:the_employee/screens/admin_login/models/admin_login_model.dart';
import 'package:the_employee/screens/employee_data_screen/models/employee_data_model.dart';
import 'package:the_employee/screens/employee_data_screen/models/employee_data_model.dart';
import 'package:the_employee/screens/home_screen/models/home_model.dart';

class AdminPanelProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<EmployeeDataModel> _list = [];

  List<EmployeeDataModel> get list => _list;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchAllEmployeeData() async {
    var res = await FirebaseDatabaseService().fetchAllEmpData();

    if (res != null) {
      _list = res;
    }
    notifyListeners();
  }
}
