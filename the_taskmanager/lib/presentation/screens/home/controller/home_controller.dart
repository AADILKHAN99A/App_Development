import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:the_taskmanager/data/Models/signup_model.dart';
import 'package:the_taskmanager/data/repository/database_helper.dart';
import '../../../../common/widgets/button.dart';
import '../../../../data/Models/task.dart';
import '../../../../data/services/notification/notification_services.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utils.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  var selectedDate = DateTime.now().obs;
  late NotificationService notifyHelper;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    notifyHelper = NotificationService();
    notifyHelper.initializeNotifications();
  }

  late SignUpModel model;
  var allTaskList = <Task>[].obs;

  getAllTaskList() async {
    var res =
        await FirebaseDatabaseService().fetchAllTaskData(email: model.email);
    if (res != null) {
      allTaskList.value = res;
    }
  }

  addNewTask({required Task task}) async {
    allTaskList.add(task);
  }

  deleteTask(Task task) async {
    var res = await FirebaseDatabaseService()
        .deleteTask(task: task, email: model.email);

    if (res != null) {
      allTaskList.remove(task);
    }
  }

  editTask(int index) {


  }

  setToComplete({required int index}) async {
    var res = await FirebaseDatabaseService()
        .setCompleteTask(task: allTaskList[index], email: model.email);

    if (res != null) {
      allTaskList[index].isCompleted = 1;
      getAllTaskList();
    }
  }
}
