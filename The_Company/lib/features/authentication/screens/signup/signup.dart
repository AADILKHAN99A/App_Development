import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/common/widgets/login_signup/form_divider.dart';
import 'package:the_company/common/widgets/login_signup/social_buttons.dart';
import 'package:the_company/features/authentication/screens/login/widgets/login_header.dart';
import 'package:the_company/features/authentication/screens/signup/widgets/signup_header.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/constants/texts.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';
import 'package:the_company/utils/validators/validators.dart';
import '../../../../common/widgets/textfield.dart';
import 'widgets/signup_form.dart';
import '../../../../utils/constants/color.dart';
import '../../../../utils/constants/image_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        /// Background
        height: HelperFunctions.screenHeight(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    CImages.blueBackgroundWithRoundBorderSquarePatterns),
                fit: BoxFit.cover)),
        child: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: CSizes.sm),
            child: Column(
              children: [
                /// Logo
                SignupHeader(),
                SizedBox(height: CSizes.defaultSpace),

                /// Form with Content
                SignUpForm(),
                SizedBox(
                  height: CSizes.defaultSpace,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class FullName extends StatelessWidget {
  const FullName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: CommonTextField(
              label: "First Name",
              controller: TextEditingController(),
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Iconsax.user),
              validator: Validators.validateName),
        ),
        const SizedBox(
          width: CSizes.spaceBtwInputFields,
        ),
        Flexible(
          child: CommonTextField(
              label: "Last Name",
              controller: TextEditingController(),
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Iconsax.user),
              validator: Validators.validateName),
        ),
      ],
    );
  }
}


