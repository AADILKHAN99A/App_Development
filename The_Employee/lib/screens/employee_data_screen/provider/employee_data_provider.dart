import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:the_employee/routes/app_routes.dart';
import 'package:the_employee/screens/employee_data_screen/models/employee_data_model.dart';
import 'package:the_employee/utils/color_constants.dart';
import 'package:the_employee/utils/custom_toast.dart';

import '../../../database/database_helper.dart';

class EmployeeDataProvider extends ChangeNotifier {
  late EmployeeDataModel employeeDataModel;
  late String primaryEmail;

  void initEmpData(EmployeeDataModel employeeDataModel, String primaryEmail) {
    this.employeeDataModel = employeeDataModel;
    this.primaryEmail = primaryEmail;
  }

  Future<void> editDetails(BuildContext context) async {
    EmployeeDataModel homeModel = EmployeeDataModel(
        fullName: employeeDataModel.fullName,
        email: employeeDataModel.email,
        phone: employeeDataModel.phone,
        workDetails: employeeDataModel.workDetails,
        joinDate: employeeDataModel.joinDate,
        isActive: employeeDataModel.isActive,
        aboutMe: employeeDataModel.aboutMe,
        skills: employeeDataModel.skills);
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

  showDetails(BuildContext context, DialogType type) {
    showDialog(
        context: context,
        builder: (builder) => SimpleDialog(
              backgroundColor: type == DialogType.email
                  ? const Color(lightSkyBlue)
                  : const Color(lightPink),
              children: [
                Icon(
                  type == DialogType.email ? Icons.email_outlined : Icons.phone,
                  color: Colors.white,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      copyToClipboard(type == DialogType.email
                          ? employeeDataModel.email
                          : '+91${employeeDataModel.phone}');
                      Navigator.pop(context);
                    },
                    child: Text(
                      type == DialogType.email
                          ? employeeDataModel.email
                          : '+91${employeeDataModel.phone}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    ),
                  ),
                )
              ],
            ));
  }

  void copyToClipboard(String text) {
    var data = ClipboardData(text: text);
    Clipboard.setData(data);
    commonToast("Copied To Clipboard");
  }
}

enum DialogType { email, phone }
