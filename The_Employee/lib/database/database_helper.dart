import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_employee/database/database_constants.dart';
import 'package:the_employee/screens/admin_login/models/admin_login_model.dart';
import 'package:the_employee/screens/admin_panel_screen/models/admin_panel_model.dart';
import 'package:the_employee/screens/employee_data_screen/models/employee_data_model.dart';
import 'package:the_employee/screens/signup_screen/models/signup_model.dart';

class FirebaseDatabaseService {
  Future<String> addUser(
      {required SignUpModel signUpModel, required String uid}) async {
    try {
      final users = FirebaseFirestore.instance
          .collection(employeeCollection)
          .doc(signUpModel.email);
      // Call the user's CollectionReference to add a new user
      await users.set({
        'name': signUpModel.name,
        'email': signUpModel.email,
        'phone': signUpModel.phone,
        'password': signUpModel.password,
        'userid': uid
      });

      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<Map?> getUser({required email}) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection(employeeCollection);
      final snapshot = await users.doc(email).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        print(data);

        return data;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> writeDetails(
      {required EmployeeDataModel empModel, required String email}) async {
    try {
      final usersData = FirebaseFirestore.instance
          .collection(employeeDetailsCollection)
          .doc(email);
      // Call the user's CollectionReference to add a new user
      await usersData.set(empModel.toMap());

      return 'success';
    } catch (e) {
      return 'Error Writing';
    }
  }

  Future<EmployeeDataModel?> getUserDetails({required primaryEmail}) async {
    try {
      CollectionReference usersData =
          FirebaseFirestore.instance.collection(employeeDetailsCollection);
      final snapshot = await usersData.doc(primaryEmail).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        EmployeeDataModel model = EmployeeDataModel.fromMap(data);

        return model;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AdminLoginModel?> checkAdmin({required AdminLoginModel model}) async {
    try {
      CollectionReference adminData =
          FirebaseFirestore.instance.collection(adminCollection);
      final snapshot = await adminData.doc(model.email).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        AdminLoginModel model = AdminLoginModel.fromMap(data);

        return model;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<AdminPanelModel>?> fetchAllEmpData() async {
    try {
      CollectionReference allEmpData =
          FirebaseFirestore.instance.collection(employeeDetailsCollection);
      final snapshot = await allEmpData.get();

      final data = snapshot.docs;
      List<AdminPanelModel> list = [];

      if (data.isNotEmpty) {
        for (var element in data) {
          list.add(AdminPanelModel.fromMap(
              element.data() as Map<String, dynamic>, element.id));
        }
        return list;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
