
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HelperFunctions{

  static double getScreenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double getScreenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

}