import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_taskmanager/common/widgets/button.dart';
import 'package:the_taskmanager/presentation/screens/edit_task/edit_task_screen.dart';
import 'package:the_taskmanager/presentation/screens/home/controller/home_controller.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:the_taskmanager/utils/constants/sizes.dart';

import '../../../../common/widgets/task_tile.dart';
import '../../../../data/Models/task.dart';

class ShowTask extends StatelessWidget {
  ShowTask({super.key});

  HomeController controller = HomeController.instance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(() => ListView.builder(
              itemCount: controller.allTaskList.length,
              itemBuilder: (context, index) {
                Task task = controller.allTaskList[index];

                if (task.repeat == "Daily") {
                  var date = DateFormat('h:mm a').parse(task.startTime);
                  var myTime = DateFormat("HH:mm").format(date);

                  controller.notifyHelper.scheduleNotification(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      task);
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showAlertDialog(
                                  task: task,
                                  deleteTaskOnTap: () {
                                    controller.deleteTask(task);
                                    Get.back();
                                  },
                                  taskCompletedOnTap: () {
                                    controller.setToComplete(index: index);
                                    Get.back();
                                  },
                                  editTaskOnTap: () {
                                    Get.to(() => EditTaskScreen(), arguments: [
                                      {"index": index}
                                    ]);
                                    Get.back();
                                  });
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ))));
                }

                if (task.date ==
                    DateFormat.yMd().format(controller.selectedDate.value)) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                          child: FadeInAnimation(
                              child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showAlertDialog(
                                  task: task,
                                  deleteTaskOnTap: () {
                                    controller.deleteTask(task);
                                    Get.back();
                                  },
                                  taskCompletedOnTap: () {
                                    controller.setToComplete(index: index);
                                    Get.back();
                                  },
                                  editTaskOnTap: () {
                                    Get.to(() => EditTaskScreen(), arguments: [
                                      {"index": index}
                                    ]);
                                    Get.back();
                                  });
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ))));
                } else {
                  return Container();
                }
              },
            )));
  }

  _showAlertDialog(
      {required Task task,
      VoidCallback? taskCompletedOnTap,
      VoidCallback? deleteTaskOnTap,
      VoidCallback? editTaskOnTap}) {
    return Get.defaultDialog(
        title: "Options",
        content: Container(
          padding: const EdgeInsets.only(top: 4),
          child: Padding(
            padding: const EdgeInsets.all(CSizes.defaultSpace),
            child: Column(
              children: [
                if (task.isCompleted == 0)
                  MyButton(
                    label: "Task Completed",
                    onTap: taskCompletedOnTap,
                  ),
                const SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
                MyButton(
                  label: "Edit Task",
                  color: Colors.pink,
                  onTap: editTaskOnTap,
                ),
                const SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
                MyButton(
                  label: "Delete Task",
                  color: Colors.redAccent,
                  onTap: deleteTaskOnTap,
                ),
                const SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
                MyButton(
                  label: "Close",
                  color: Colors.white,
                  labelColor: Colors.black,
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
        ));
  }
}
