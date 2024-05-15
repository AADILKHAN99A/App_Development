import 'package:flutter/widgets.dart';
import 'package:the_employee/routes/app_routes.dart';
import 'package:the_employee/screens/employee_data_screen/models/employee_data_model.dart';
import 'package:the_employee/screens/home_screen/models/home_model.dart';

import '../../../database/database_helper.dart';

class EmployeeDataProvider extends ChangeNotifier {
  Future<void> editDetails(BuildContext context, EmployeeDataModel model,
      String primaryEmail) async {
    HomeModel homeModel = HomeModel(
        fullName: model.fullName,
        email: model.email,
        phone: model.phone,
        workDetails: model.workDetails,
        joinDate: model.joinDate,
        isActive: model.isActive);
    var updated = await Navigator.pushNamed(
        context, RouteName.employeeDataEditScreen,
        arguments: {'data': homeModel, 'primaryEmail': primaryEmail});

    if (updated == true) {
      final res = await FirebaseDatabaseService()
          .getUserDetails(primaryEmail: primaryEmail);

      Navigator.pushReplacementNamed(context, RouteName.employeeDataScreen,
          arguments: {'data': res, 'primaryEmail': primaryEmail});
    }
  }
}
