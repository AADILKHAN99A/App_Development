import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_company/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:the_company/features/authentication/screens/onboarding/widgets/onboarding_next_navigation.dart';
import 'package:the_company/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:the_company/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:the_company/utils/constants/image_strings.dart';
import 'package:the_company/utils/constants/texts.dart';
import 'package:the_company/features/authentication/controllers.onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                  image: CImages.onBoardingImageShopping,
                  title: CTexts.onBoardingTitle1,
                  subtitle: CTexts.onBoardingSubTitle1),
              OnBoardingPage(
                  image: CImages.onBoardingImagePayment,
                  title: CTexts.onBoardingTitle2,
                  subtitle: CTexts.onBoardingSubTitle2),
              OnBoardingPage(
                  image: CImages.onBoardingImageDelivery,
                  title: CTexts.onBoardingTitle3,
                  subtitle: CTexts.onBoardingSubTitle3)
            ],
          ),

          /// Skip Button
          const OnBoardingSkip(),

          /// Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          /// Circular Button

          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
