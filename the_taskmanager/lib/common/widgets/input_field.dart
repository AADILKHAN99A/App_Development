import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_taskmanager/utils/constants/colors.dart';
import 'package:the_taskmanager/utils/constants/sizes.dart';

class MyInputField extends StatelessWidget {
  const MyInputField(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget});

  final String title, hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: CSizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Container(
            margin: const EdgeInsets.only(top: CSizes.sm),
            height: 52,
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  cursorColor: Get.isDarkMode ? Colors.white : Colors.black,
                  controller: controller,
                  decoration: InputDecoration(hintText: hint),
                )),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
                // Expanded(child: widget)
              ],
            ),
          )
        ],
      ),
    );
  }
}
