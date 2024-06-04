import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:the_company/common/styles/spacing_styles.dart';
import 'package:the_company/common/widgets/success_screen/success_screen.dart';
import 'package:the_company/features/authentication/screens/login/login.dart';
import 'package:the_company/utils/constants/image_strings.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/constants/texts.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyles.paddingWithDefaultSpaces,
          child: Column(
            children: [
              /// Image

              SvgPicture.asset(
                CImages.deliveredEmail,
                width: HelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              /// Title & SubTitle
              Text(
                CTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),

              Text(
                'asdf@gmail.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),
              Text(
                CTexts.confirmEmailSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              /// Buttons

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => SuccessScreen(
                        image: CImages.successEmailVerification,
                        title: CTexts.yourAccountCreatedTitle,
                        subtitle: CTexts.yourAccountCreatedSubtitle,
                        onPressed: () => Get.to(() => const LoginScreen()),
                      )),
                  child: const Text(CTexts.cContinue),
                ),
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(CTexts.resendEmail),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
