import 'package:flutter/Material.dart';
import 'package:the_employee/database/database_helper.dart';
import 'package:the_employee/routes/app_routes.dart';
import 'package:the_employee/screens/home_screen/models/home_model.dart';
import 'package:the_employee/utils/custom_toast.dart';

class HomeProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  bool _isActive = true;

  bool get isActive => _isActive;

  setActive(bool value){
    _isActive=value;
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      print(picked);
      _selectedDate = picked;

      notifyListeners();
    }
  }

  writeData(
      {required String email,
      required String phone,
      required String fullName,
      required String workDetails,
      required String primaryEmail,
      required BuildContext context}) async {
    HomeModel model = HomeModel(
        fullName: fullName,
        email: email,
        phone: phone,
        workDetails: workDetails,
        joinDate: _selectedDate,
        isActive: _isActive);

    await FirebaseDatabaseService()
        .writeDetails(homeModel: model, email: primaryEmail)
        .then((value) {
      if (value.contains('success')) {
        commonToast("Details Submit");
        //navigate
        Navigator.pushReplacementNamed(context, RouteName.employeeDataScreen,
            arguments: {'data': model, 'primaryEmail': primaryEmail});
      } else {
        commonToast("Something Wrong!");
        // show error
      }
    });
  }
}
