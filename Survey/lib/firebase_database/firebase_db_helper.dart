import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:survey/database_helper.dart';

class FirebaseDatabaseService {
  Future<String> addUser({
    required String? fullName,
    required String? email,
    required String? phone,
    required String? password,
    required String uid
  }) async {
    try {
      final users = FirebaseFirestore.instance.collection('users').doc(uid);
      // Call the user's CollectionReference to add a new user
      await users.set({
        'full_name': fullName ?? "Your Name",
        'email': email ?? "",
        'phone': phone ?? "",
        'password': password ?? "",
        'userid': uid
      });
      await DatabaseHelper.instance.insertUser(userid: uid, email: email);
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<Object?> getUser({required uid}) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users.doc("$uid").get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        print(data);

        return data;
      } else {
        return 'User not found!';
      }
    } catch (e) {
      return 'Error fetching user';
    }
  }
}
