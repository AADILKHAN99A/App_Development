import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_taskmanager/common/widgets/button.dart';
import 'package:the_taskmanager/presentation/screens/login/controller/login_controller.dart';
import 'package:the_taskmanager/presentation/screens/signup/signup_screen.dart';
import 'package:the_taskmanager/utils/constants/image_strings.dart';
import 'package:the_taskmanager/utils/constants/sizes.dart';
import 'package:the_taskmanager/utils/validators/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: controller.key,
          child: Column(
            children: [
              Image.asset(CImages.appIcon),
              Text(
                "Hi, Welcome back!",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: CSizes.spaceBtwSections,
              ),
              _buildEmailTextField(context),
              _buildPasswordTextField(context),
              const SizedBox(
                height: 26,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
                child: MyButton(
                  label: "Login",
                  onTap: () {
                    controller.validate();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const SignUpScreen());
                      },
                      child: const Text("Sign up"))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: CSizes.defaultSpace, vertical: CSizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email", style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(
            height: CSizes.sm,
          ),
          TextFormField(
            controller: controller.emailController,
            validator: Validators.validateEmail,
            decoration: InputDecoration(
              hintText: "Enter your email address",
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(color: Colors.grey),
              contentPadding: const EdgeInsets.only(left: 22, bottom: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: CSizes.defaultSpace, vertical: CSizes.spaceBtwItems),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Password",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: CSizes.sm,
        ),
        Obx(() => TextFormField(
              obscureText: controller.obsecurePassword.value,
              controller: controller.passController,
              validator: Validators.validatePassword,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.obsecurePassword.value =
                          !controller.obsecurePassword.value;
                    },
                    child: Icon(controller.obsecurePassword.value
                        ? Icons.remove_red_eye_rounded
                        : Icons.remove_red_eye_outlined),
                  ),
                  hintText: "Enter your password",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: Colors.grey)),
            ))
      ]),
    );
  }
}
