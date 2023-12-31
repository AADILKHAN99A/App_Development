import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:survey/database_helper.dart';

class FirebaseDatabaseService {
  Future<String> addUser({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final users = FirebaseFirestore.instance.collection('users').doc();
      // Call the user's CollectionReference to add a new user
      await users.set({
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'password': password,
        'userid': users.id
      });
      await DatabaseHelper.instance.insertUser(userid: users.id, email: email);
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<String?> getUser() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users.doc().get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        print(data);

        return '';
      } else {
        return 'User not found!';
      }
    } catch (e) {
      return 'Error fetching user';
    }
  }
}
