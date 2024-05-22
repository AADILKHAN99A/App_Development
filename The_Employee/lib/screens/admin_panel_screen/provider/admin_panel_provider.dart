import 'package:flutter/Material.dart';
import 'package:the_employee/database/database_helper.dart';
import 'package:the_employee/screens/admin_panel_screen/models/admin_panel_model.dart';

class AdminPanelProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<AdminPanelModel> _list = [];

  List<AdminPanelModel> get list => _list;

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
