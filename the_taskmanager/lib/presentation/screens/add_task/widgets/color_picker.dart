import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_taskmanager/presentation/screens/add_task/controller/add_task_controller.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key, required this.controller});
  final  controller;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Color",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Obx(() => Wrap(
                children: List<Widget>.generate(
                    3,
                    (int index) => GestureDetector(
                          onTap: () {
                            controller.selectedColor.value = index;
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: CSizes.sm, top: CSizes.sm),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: index == 0
                                  ? CColors.primary
                                  : index == 1
                                      ? CColors.pink
                                      : CColors.yellow,
                              child: controller.selectedColor.value == index
                                  ? const Icon(Icons.done, color: Colors.white)
                                  : null,
                            ),
                          ),
                        ))))
          ],
        )
      ],
    );
  }
}
