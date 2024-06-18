import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_taskmanager/presentation/screens/add_task/add_task_screen.dart';
import 'package:the_taskmanager/presentation/screens/home/controller/home_controller.dart';

import '../../../../common/widgets/button.dart';
import '../../../../utils/constants/sizes.dart';

class AddTaskBar extends StatelessWidget {
   const AddTaskBar({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: CSizes.spaceBtwItems, vertical: CSizes.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "Today",
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          ),
          MyButton(
            icon: Icons.add,
            label: "Add Task",
            onTap: () {
              Get.to(AddTaskScreen());
            },
          )
        ],
      ),
    );
  }
}
