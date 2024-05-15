import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_expenses/database/database_constants.dart';

import '../screens/signup_screen/models/signup_model.dart';

class FirebaseDatabaseService {
  Future<String> addUser(
      {required SignUpModel signUpModel, required String uid}) async {
    try {
      final users = FirebaseFirestore.instance
          .collection(userCollection)
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
          FirebaseFirestore.instance.collection(userCollection);
      final snapshot = await users.doc(email).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        return data;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
//
// Future<String> writeDetails(
//     {required HomeModel homeModel, required String email}) async {
//   try {
//     final usersData = FirebaseFirestore.instance
//         .collection(employeeDetailsCollection)
//         .doc(email);
//     // Call the user's CollectionReference to add a new user
//     await usersData.set(homeModel.toMap());
//
//     return 'success';
//   } catch (e) {
//     return 'Error Writing';
//   }
// }
//
// Future<EmployeeDataModel?> getUserDetails({required primaryEmail}) async {
//   try {
//     CollectionReference usersData =
//         FirebaseFirestore.instance.collection(employeeDetailsCollection);
//     final snapshot = await usersData.doc(primaryEmail).get();
//     if (snapshot.exists) {
//       final data = snapshot.data() as Map<String, dynamic>;
//       EmployeeDataModel model = EmployeeDataModel.fromMap(data);
//
//       return model;
//     }
//     return null;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }
//
// Future<AdminLoginModel?> checkAdmin({required AdminLoginModel model}) async {
//   try {
//     CollectionReference adminData =
//         FirebaseFirestore.instance.collection(adminCollection);
//     final snapshot = await adminData.doc(model.email).get();
//     if (snapshot.exists) {
//       final data = snapshot.data() as Map<String, dynamic>;
//       AdminLoginModel model = AdminLoginModel.fromMap(data);
//
//       return model;
//     }
//     return null;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }
//
// Future<List<EmployeeDataModel>?> fetchAllEmpData() async {
//   try {
//     CollectionReference allEmpData =
//         FirebaseFirestore.instance.collection(employeeDetailsCollection);
//     final snapshot = await allEmpData.get();
//
//     final data = snapshot.docs;
//     List<EmployeeDataModel> list = [];
//     if (data.isNotEmpty) {
//       for (var element in data) {
//         list.add(EmployeeDataModel.fromMap(element.data() as Map<String, dynamic>));
//       }
//       return list;
//     }
//
//     return null;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }
}
