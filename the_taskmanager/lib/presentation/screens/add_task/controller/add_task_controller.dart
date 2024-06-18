import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_taskmanager/common/widgets/snackbar.dart';
import 'package:the_taskmanager/data/Models/task.dart';
import 'package:the_taskmanager/data/repository/database_helper.dart';
import 'package:the_taskmanager/presentation/screens/home/controller/home_controller.dart';
import 'package:the_taskmanager/utils/constants/enums.dart';

class AddTaskController extends GetxController {
  static AddTaskController get instance => Get.find();
  var todayDateTime = DateTime.now().obs;

  var endTime = "9:30 PM".obs;
  var startTime = DateFormat("hh:mm a").format(DateTime.now()).toString().obs;
  var selectedRemind = 5.obs;

  var remindList = [5, 10, 15, 20].obs;
  var selectedRepeat = "None".obs;
  var repeatList = ["None", "Daily", "Weekly", "Monthly"].obs;

  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var selectedColor = 0.obs;

  HomeController controller = HomeController.instance;

  getDateFromUser({required BuildContext context}) async {
    DateTime? _pickerDate = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime(2015),
        lastDate: DateTime(2125));

    if (_pickerDate != null) {
      todayDateTime.value = _pickerDate;
    }
  }

  validateTask() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      // add to database
      addTask();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      CustomSnackBar.showSnackBar(
          title: "Required",
          message: "All Fields are Required",
          type: SnackBarType.alert);
    }
  }

  getTimeFromUser(
      {required bool isStarTime, required BuildContext context}) async {
    var pickedTime = await _showTimePicker(context: context);
    String? formatedTime = pickedTime?.format(context);

    if (pickedTime == null) {
      print("Canceled");
    } else if (isStarTime == true) {
      startTime.value = formatedTime!;
    } else {
      endTime.value = formatedTime!;
    }
  }

  Future<TimeOfDay?> _showTimePicker({required BuildContext context}) async {
    return showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: TimeOfDay(
            hour: int.parse(startTime.value.split(":")[0]),
            minute: int.parse(startTime.value.split(":")[1].split(" ")[0])));
  }

  addTask() async {
    var task = Task(
        title: titleController.text,
        note: noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(todayDateTime.value),
        startTime: startTime.value,
        endTime: endTime.value,
        color: selectedColor.value,
        remind: selectedRemind.value,
        repeat: selectedRepeat.value);

    var responseTask = await FirebaseDatabaseService().addTask(
        task: task,
        email: controller.model.email);

    if (responseTask != null) {
      controller.addNewTask(task: responseTask);
    }
  }
}
