import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:the_company/navigation_menu.dart';
import '../../../../../common/styles/spacing_styles.dart';
import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../../common/widgets/textfield.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/validators/validators.dart';
import '../../signup/signup.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Card(
      margin: SpacingStyles.paddingWithDefaultSpaces,
      elevation: CSizes.cardElevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CSizes.cardRadiusLg)),
      child: Padding(
        padding: SpacingStyles.paddingWithBtwItemSpaces,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Email
              CommonTextField(
                controller: TextEditingController(),
                prefixIcon: const Icon(Iconsax.direct_right),
                keyboardType: TextInputType.emailAddress,
                label: CTexts.email,
                validator: Validators.validateEmail,
              ),
              const SizedBox(
                height: CSizes.spaceBtwInputFields,
              ),

              /// Password
              CommonTextField(
                label: CTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Iconsax.eye_slash)),
                keyboardType: TextInputType.visiblePassword,
                validator: Validators.validatePassword,
                controller: TextEditingController(),
              ),
              const SizedBox(
                height: CSizes.spaceBtwInputFields / 2,
              ),

              /// Remember Me & Forget Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Remember Me
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      const Text(CTexts.rememberMe)
                    ],
                  ),

                  /// Forget Password
                  TextButton(
                      onPressed: () => Get.to(() => const ForgetPasswordScreen()),
                      child: const Text(CTexts.forgotPassword))
                ],
              ),
              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              /// Sign In Button
              ElevatedButton(
                  onPressed: () => Get.to(() => const NavigationMenu()),
                  child: const Text(
                    CTexts.signIn,
                  )),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),

              /// Sign In Button
              OutlinedButton(
                  onPressed: () => Get.to(() => const SignupScreen()),
                  child: const Text(
                    CTexts.createAccount,
                  )),

              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              /// Divider
              FormDivider(
                dividerText: CTexts.orSignInWith.capitalize!,
              ),
              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),

              /// Footer
              const SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
