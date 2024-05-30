import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  /// variables
  final PageController pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  /// Update current Index when page scroll
  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  /// Jump to the specific dot selected page.
  void dotNavigationClick(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  /// Update Current Index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      // Get.to(Login)
    } else {
      currentPageIndex.value = currentPageIndex.value+1;
      int page = currentPageIndex.value;
      pageController.jumpToPage(page);
    }
  }

  /// Update Current Index & jump to the last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
