import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_employee/database/database_helper.dart';
import 'package:the_employee/screens/admin_panel_screen/models/admin_panel_model.dart';
import 'package:the_employee/utils/color_constants.dart';
import 'package:the_employee/widgets/custom_bottom_sheet.dart';

import '../../../routes/app_routes.dart';
import '../../employee_data_screen/models/employee_data_model.dart';

class AdminPanelProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  void toggleSearching() {
    _isSearching = !isSearching;
    clearSearch();
    notifyListeners();
  }

  void clearSearch() {
    searchedList.clear();
  }

  List<AdminPanelModel> _list = [];

  List<AdminPanelModel> get list => _list;
  TextEditingController controller = TextEditingController();
  List<AdminPanelModel> searchedList = [];

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

  void searchList(String query) {
    clearSearch();
    for (AdminPanelModel item in _list) {
      if (item.fullName.toLowerCase().contains(query.toLowerCase())) {
        searchedList.add(item);
      }
    }
    notifyListeners();
  }

  navigate(BuildContext context, AdminPanelModel model) {
    EmployeeDataModel employeeDataModel = EmployeeDataModel(
        fullName: model.fullName,
        email: model.email,
        phone: model.phone,
        workDetails: model.workDetails,
        joinDate: model.joinDate,
        isActive: model.isActive,
        aboutMe: model.aboutMe,
        skills: model.skills);
    Navigator.pushNamed(context, RouteName.employeeDataScreen,
        arguments: {'data': employeeDataModel, 'primaryEmail': model.id});
  }
}
