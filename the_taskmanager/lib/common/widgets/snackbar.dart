import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_taskmanager/utils/constants/colors.dart';
import 'package:the_taskmanager/utils/constants/enums.dart';

class CustomSnackBar {
  static showSnackBar(
      {required String title,
      required String message,
      required SnackBarType type}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: type == SnackBarType.alert
            ? Colors.redAccent
            : type == SnackBarType.warning
                ? CColors.yellow
                : CColors.blue,
        colorText: Colors.white,
        icon: Icon(
          type == SnackBarType.alert
              ? Icons.message_outlined
              : type == SnackBarType.warning
                  ? Icons.warning_amber_rounded
                  : Icons.check_circle_outlined,
          color: Colors.white,
        ));
  }
}
