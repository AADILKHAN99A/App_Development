import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_taskmanager/presentation/screens/home/controller/home_controller.dart';

import '../../../../utils/constants/colors.dart';

class AddDateBar extends StatelessWidget {
  AddDateBar({
    super.key,
  });

  HomeController controller = HomeController.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20, left: 20),
        child: Obx(() => DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: controller.selectedDate.value,
              selectionColor: CColors.primary,
              selectedTextColor: CColors.white,
              dateTextStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: CColors.darkGrey),
              dayTextStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: CColors.darkGrey),
              monthTextStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(color: CColors.darkGrey),
              onDateChange: (date) {
                controller.selectedDate.value = date;
                controller.getAllTaskList();
                print("new date value is : ${controller.selectedDate.value}");
              },
            )));
  }
}
