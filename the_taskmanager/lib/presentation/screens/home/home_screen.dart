import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:the_taskmanager/common/widgets/app_bar.dart';
import 'package:the_taskmanager/common/widgets/button.dart';
import 'package:the_taskmanager/data/services/notification/notification_services.dart';
import 'package:the_taskmanager/data/services/theme_services.dart';
import 'package:the_taskmanager/presentation/screens/home/controller/home_controller.dart';
import 'package:the_taskmanager/presentation/screens/home/widgets/add_date_bar.dart';
import 'package:the_taskmanager/presentation/screens/home/widgets/add_task_bar.dart';
import 'package:the_taskmanager/presentation/screens/home/widgets/show_task.dart';
import 'package:the_taskmanager/utils/constants/colors.dart';
import 'package:the_taskmanager/utils/constants/image_strings.dart';
import 'package:the_taskmanager/utils/constants/sizes.dart';

import '../../../data/Models/task.dart';
import '../../../utils/device/device_utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  var arguments = Get.arguments;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = Get.put(HomeController());

    controller.model = widget.arguments[0]['data'];
    controller.getAllTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Home"),
        leadingIcon: Icons.nightlight_round,
        leadingOnPressed: () {
          ThemeServices().switchTheme();
          // controller.notifyHelper.scheduleNotification(
          //     10,
          //     12,
          //     Task(
          //         title: "title",
          //         note: "note",
          //         isCompleted: 1,
          //         date: "date",
          //         startTime: "startTime",
          //         endTime: "endTime",
          //         color: 1,
          //         remind: 5,
          //         repeat: "repeat"));
        },
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage(CImages.profileIcon),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const AddTaskBar(),
          AddDateBar(),
          const SizedBox(
            height: CSizes.spaceBtwItems,
          ),
          ShowTask(),
        ],
      ),
    );
  }
}
