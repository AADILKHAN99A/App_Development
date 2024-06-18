import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_taskmanager/common/widgets/snackbar.dart';
import 'package:the_taskmanager/data/Models/task.dart';
import 'package:the_taskmanager/presentation/screens/home/controller/home_controller.dart';
import 'package:the_taskmanager/utils/constants/enums.dart';

import '../../../../data/repository/database_helper.dart';

class EditTaskController extends GetxController {
  static EditTaskController get instance => Get.find();
  var todayDateTime = DateTime.now().obs;
  HomeController controller = HomeController.instance;

  updateAllData({required int index}) {
    endTime.value = controller.allTaskList[index].endTime;
    selectedRepeat.value = controller.allTaskList[index].repeat;
    titleController.text = controller.allTaskList[index].title;
    noteController.text = controller.allTaskList[index].note;
    todayDateTime.value =
        DateFormat.yMd().parse(controller.allTaskList[index].date);
    startTime.value = controller.allTaskList[index].startTime;
    selectedRemind.value = controller.allTaskList[index].remind;
    selectedRepeat.value = controller.allTaskList[index].repeat;
    selectedColor.value = controller.allTaskList[index].color;
  }

  var endTime = "9:30 PM".obs;
  var startTime = DateFormat("hh:mm a").format(DateTime.now()).toString().obs;
  var selectedRemind = 5.obs;

  var remindList = [5, 10, 15, 20].obs;
  var selectedRepeat = "None".obs;
  var repeatList = ["None", "Daily", "Weekly", "Monthly"].obs;

  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var selectedColor = 0.obs;

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

  validateTask({required int index}) {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      // add to database
      doneEdit(index: index);
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

  doneEdit({required int index}) async {
    var task = Task(
      id: controller.allTaskList[index].id,
        title: titleController.text,
        note: noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(todayDateTime.value),
        startTime: startTime.value,
        endTime: endTime.value,
        color: selectedColor.value,
        remind: selectedRemind.value,
        repeat: selectedRepeat.value);

    print(task.toJson());

    var responseTask = await FirebaseDatabaseService()
        .editTask(task: task, email: controller.model.email);

    if (responseTask != null) {
      controller.allTaskList[index] = task;
    }
  }
}
