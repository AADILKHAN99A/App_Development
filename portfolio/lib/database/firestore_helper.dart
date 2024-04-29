import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference _inbox = firebaseFirestore.collection('Inbox');

  Future writeEntry(
      {required String name,
      required String email,
      required String subject,
      required String message}) async {
    try {
      await _inbox.doc().set({
        'name': name,
        'email': email,
        'subject': subject,
        'message': message
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
