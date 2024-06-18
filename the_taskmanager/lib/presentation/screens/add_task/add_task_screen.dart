import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:the_taskmanager/common/widgets/app_bar.dart';
import 'package:the_taskmanager/common/widgets/button.dart';
import 'package:the_taskmanager/common/widgets/input_field.dart';
import 'package:the_taskmanager/presentation/screens/add_task/controller/add_task_controller.dart';
import 'package:the_taskmanager/presentation/screens/add_task/widgets/color_picker.dart';
import 'package:the_taskmanager/utils/constants/colors.dart';
import 'package:the_taskmanager/utils/constants/sizes.dart';

import '../../../data/services/theme_services.dart';
import '../../../utils/constants/image_strings.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  AddTaskController controller = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Add Task"),
        showBackArrow: true,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage(CImages.profileIcon),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
        child: Column(
          children: [
            MyInputField(
              title: "Title",
              hint: "Enter your title",
              controller: controller.titleController,
            ),
            MyInputField(
              title: "Note",
              hint: "Enter your note",
              controller: controller.noteController,
            ),
            Obx(() => MyInputField(
                  title: "Date",
                  hint: DateFormat.yMd().format(controller.todayDateTime.value),
                  widget: IconButton(
                      onPressed: () {
                        controller.getDateFromUser(context: context);
                      },
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      )),
                )),
            Obx(() => Row(
                  children: [
                    Expanded(
                        child: MyInputField(
                      title: "Start Time",
                      hint: controller.startTime.value,
                      widget: IconButton(
                          onPressed: () {
                            controller.getTimeFromUser(
                                isStarTime: true, context: context);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          )),
                    )),
                    Expanded(
                        child: MyInputField(
                      title: "End Time",
                      hint: controller.endTime.value,
                      widget: IconButton(
                          onPressed: () {
                            controller.getTimeFromUser(
                                isStarTime: false, context: context);
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          )),
                    ))
                  ],
                )),
            Obx(() => MyInputField(
                  title: "Remind",
                  hint: "${controller.selectedRemind} minutes early",
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey),
                    iconSize: 32,
                    elevation: 4,
                    underline: Container(
                      height: 0,
                    ),
                    items: controller.remindList
                        .map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      controller.selectedRemind.value = int.parse(value!);
                    },
                  ),
                )),
            Obx(() => MyInputField(
                  title: "Repeat",
                  hint: controller.selectedRepeat.value,
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey),
                    iconSize: 32,
                    underline: Container(
                      height: 0,
                    ),
                    elevation: 4,
                    items: controller.repeatList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      controller.selectedRepeat.value = value!;
                    },
                  ),
                )),
            const SizedBox(
              height: CSizes.spaceBtwItems,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ColorPicker(controller: AddTaskController.instance,),
                MyButton(
                  label: "Create Task",
                  onTap: () {
                    controller.validateTask();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
