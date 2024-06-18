import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_taskmanager/data/Models/task.dart';

import '../Models/signup_model.dart';
import 'database_constants.dart';

class FirebaseDatabaseService {
  Future<String> addUser({required SignUpModel signUpModel}) async {
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
      });

      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<SignUpModel?> getUser({required email}) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection(userCollection);
      final snapshot = await users.doc(email).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        return SignUpModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> writeDetails(
      {required Task taskModel, required String email}) async {
    try {
      final usersData =
          FirebaseFirestore.instance.collection(taskCollection).doc(email);
      // Call the user's CollectionReference to add a new user
      await usersData.set(taskModel.toJson());

      return 'success';
    } catch (e) {
      return 'Error Writing';
    }
  }

  Future<SignUpModel?> getUserDetails({required primaryEmail}) async {
    try {
      CollectionReference usersData =
          FirebaseFirestore.instance.collection(userCollection);
      final snapshot = await usersData.doc(primaryEmail).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        SignUpModel model = SignUpModel.fromJson(data);

        return model;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Task?> addTask({required Task task, required String email}) async {
    try {
      var taskData = FirebaseFirestore.instance
          .collection(taskCollection)
          .doc(email)
          .collection("tasks")
          .doc();

      task.id = taskData.id;
      await taskData.set(task.toJson());
      return task;
    } catch (e) {
      return null;
    }
  }

  Future<List<Task>?> fetchAllTaskData({required String email}) async {
    try {
      var allTaskData = FirebaseFirestore.instance
          .collection(taskCollection)
          .doc(email)
          .collection("tasks");
      final snapshot = await allTaskData.get();

      final data = snapshot.docs;
      List<Task> list = [];
      for (var element in data) {
        list.add(Task.fromJson(element.data()));
      }
      return list;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Task?> deleteTask({required Task task, required String email}) async {
    try {
      var taskData = FirebaseFirestore.instance
          .collection(taskCollection)
          .doc(email)
          .collection("tasks")
          .doc(task.id);
      await taskData.delete();
      return task;
    } catch (e) {
      return null;
    }
  }

  Future<Task?> setCompleteTask(
      {required Task task, required String email}) async {
    try {
      var taskData = FirebaseFirestore.instance
          .collection(taskCollection)
          .doc(email)
          .collection("tasks")
          .doc(task.id);
      task.isCompleted = 1;
      await taskData.update(task.toJson());
      return task;
    } catch (e) {
      return null;
    }
  }

  Future<Task?> editTask(
      {required Task task, required String email}) async {
    try {
      var taskData = FirebaseFirestore.instance
          .collection(taskCollection)
          .doc(email)
          .collection("tasks")
          .doc(task.id);
      await taskData.update(task.toJson());
      return task;
    } catch (e) {
      return null;
    }
  }
}
