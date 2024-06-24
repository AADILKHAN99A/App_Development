import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/features/authentication/screens/signup/verify_email.dart';
import 'package:the_company/features/authentication/screens/signup/widgets/terms_condition_checkbox.dart';
import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../../common/widgets/textfield.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/validators/validators.dart';
import '../signup.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: CSizes.cardElevation,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CSizes.spaceBtwItems, horizontal: CSizes.sm),
        child: Form(
          child: Column(
            children: [
              /// Full Name
              const FullName(),
              const SizedBox(
                height: CSizes.spaceBtwInputFields,
              ),

              /// Username
              CommonTextField(
                label: CTexts.username,
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Iconsax.user_edit),
                validator: Validators.validateUserName,
              ),
              const SizedBox(height: CSizes.spaceBtwInputFields),

              /// Email
              CommonTextField(
                label: CTexts.email,
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Iconsax.direct),
                validator: Validators.validateUserName,
              ),
              const SizedBox(height: CSizes.spaceBtwInputFields),

              /// Phone No
              CommonTextField(
                controller: TextEditingController(),
                keyboardType: TextInputType.phone,
                label: CTexts.phoneNo,
                prefixIcon: const Icon(Iconsax.call),
                validator: Validators.validatePhoneNumber,
              ),
              const SizedBox(height: CSizes.spaceBtwInputFields),

              /// Password
              CommonTextField(
                controller: TextEditingController(),
                keyboardType: TextInputType.visiblePassword,
                label: CTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                validator: Validators.validatePassword,
                suffixIcon: const Icon(Iconsax.eye_slash),
              ),
              const SizedBox(height: CSizes.spaceBtwInputFields),

              /// Confirm Password
              CommonTextField(
                controller: TextEditingController(),
                keyboardType: TextInputType.visiblePassword,
                label: CTexts.confirmPassword,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: const Icon(Iconsax.eye_slash),
                validator: (String? value) {
                  Validators.validateConfirmPassword(value, value);
                  return null;
                },
              ),
              const SizedBox(height: CSizes.spaceBtwInputFields),

              /// Terms and Condition

              const TermsAndCondition(),
              const SizedBox(height: CSizes.spaceBtwSections),

              /// Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const VerifyEmailScreen()),
                  child: const Text(CTexts.createAccount),
                ),
              ),
              const SizedBox(height: CSizes.spaceBtwItems),

              /// Divider
              const FormDivider(dividerText: CTexts.orSignUpWith),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),

              /// Social Buttons
              const SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
