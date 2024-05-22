import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:the_employee/screens/employee_data_screen/models/employee_data_model.dart';

import '../../../database/database_helper.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/custom_toast.dart';

class EmployeeDataEditProvider extends ChangeNotifier {
  late DateTime _selectedDate;

  DateTime get selectedDate => _selectedDate;

  set selectedDate(value) {
    _selectedDate = value;
  }

  late bool _isActive;

  bool get isActive => _isActive;

  set isActive(bool value) {
    _isActive = value;
  }

  List<dynamic> _skills = [];

  get skills => _skills;

  void setSkills(List skills) {
    _skills = skills;
  }

  void addSkill(String skill) {
    _skills.add(skill);
    notifyListeners();
  }

  void removeSkill(String skill) {
    _skills.remove(skill);
    notifyListeners();
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
      required String aboutMe,
      required BuildContext context}) async {
    EmployeeDataModel model = EmployeeDataModel(
        fullName: fullName,
        email: email,
        phone: phone,
        workDetails: workDetails,
        joinDate: _selectedDate,
        isActive: _isActive,
        skills: _skills,
        aboutMe: aboutMe);

    await FirebaseDatabaseService()
        .writeDetails(empModel: model, email: primaryEmail)
        .then((value) {
      if (value.contains('success')) {
        commonToast("Details Submit");
        //navigate

        Navigator.pop(context, true);
      } else {
        commonToast("Something Wrong!");
        // show error
      }
    });
  }
}
