import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';

import '../../../database/database_helper.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/custom_toast.dart';
import '../../home_screen/models/home_model.dart';

class EmployeeDataEditProvider extends ChangeNotifier {
  late DateTime _selectedDate;

  DateTime get selectedDate => _selectedDate;

  set selectedDate(value) {
    _selectedDate = value;
  }

  late bool _isActive ;

  bool get isActive => _isActive;

  set isActive(bool value) {
    _isActive = value;

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

        Navigator.pop(context, true);
      } else {
        commonToast("Something Wrong!");
        // show error
      }
    });
  }
}
