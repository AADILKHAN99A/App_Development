import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:the_taskmanager/presentation/screens/signup/controller/signup_controller.dart';
import 'package:the_taskmanager/utils/constants/image_strings.dart';
import 'package:the_taskmanager/utils/constants/sizes.dart';
import 'package:the_taskmanager/utils/validators/validators.dart';

import '../../../common/widgets/button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    CImages.appIcon,
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: CSizes.sm),
                    child: Text(
                      "Name",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  TextFormField(
                    controller: controller.nameController,
                    validator: Validators.validateName,
                    decoration: InputDecoration(
                        hintText: "Enter name",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(color: Colors.grey)),
                    keyboardType: TextInputType.name,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: CSizes.sm),
                    child: Text(
                      "Email",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    validator: Validators.validateEmail,
                    decoration: InputDecoration(
                        hintText: "Enter email",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(color: Colors.grey)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: CSizes.sm),
                    child: Text(
                      "Phone Number",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  TextFormField(
                    controller: controller.phoneController,
                    validator: Validators.validatePhoneNumber,
                    decoration: InputDecoration(
                        counter: const SizedBox.shrink(),
                        hintText: "Enter Phone number",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(color: Colors.grey)),
                    keyboardType: TextInputType.phone,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: CSizes.sm),
                    child: Text(
                      "Password",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      obscureText: controller.passwordVisible.value,
                      validator: Validators.validatePassword,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.passwordVisible.value =
                                !controller.passwordVisible.value;
                          },
                          child: Icon(controller.passwordVisible.value
                              ? Icons.remove_red_eye_rounded
                              : Icons.remove_red_eye_outlined),
                        ),
                        hintText: "Enter your password",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(color: Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: CSizes.sm),
                    child: Text(
                      "Confirm Password",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Obx(
                    () => TextFormField(
                      controller: controller.confirmPasswordController,
                      obscureText: controller.confirmPasswordVisible.value,
                      validator: (value) {
                        return Validators.validateConfirmPassword(
                            value, controller.passwordController.text);
                      },
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.confirmPasswordVisible.value =
                                  !controller.confirmPasswordVisible.value;
                            },
                            child: Icon(controller.confirmPasswordVisible.value
                                ? Icons.remove_red_eye_rounded
                                : Icons.remove_red_eye_outlined),
                          ),
                          hintText: "Confirm password",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .apply(color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: CSizes.sm),
                    child: MyButton(
                      label: controller.isLoading.value?null:"SignUp",
                      // icon: controller.isLoading.value?CircularProgressIndicator():null,
                      onTap: () {
                        controller.validate();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
