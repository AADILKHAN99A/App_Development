import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/features/authentication/controllers.onboarding/onboarding_controller.dart';
import '../../../../utils/constants/color.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Positioned(
        right: CSizes.defaultSpace,
        bottom: DeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: dark ? CColors.primary : Colors.black),
            onPressed: OnboardingController.instance.nextPage,
            child: const Icon(Iconsax.arrow_right_3)));
  }
}
