import 'dart:ui';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:the_employee/screens/admin_login/models/admin_login_model.dart';
import 'package:the_employee/screens/admin_login/provider/admin_login_provider.dart';
import 'package:the_employee/screens/admin_panel_screen/provider/admin_panel_provider.dart';
import 'package:the_employee/screens/login_screen/provider/login_provider.dart';
import 'package:the_employee/utils/color_constants.dart';
import 'package:the_employee/widgets/custom_elevated_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:the_employee/widgets/custom_loading_button.dart';

import '../../utils/image_constants.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool passwordVisible = true;

  void logIn(AdminLoginProvider provider) async {
    AdminLoginModel model = AdminLoginModel(
        email: emailController.text.toString(),
        password: passController.text.toString());

    await provider.adminLogin(model, context, provider);
  }

  void autoFill() {
    emailController.text = 'admin123@gmail.com';
    passController.text = '12345678';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _key,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
            child: Column(
              children: [
                const Text(
                  "Hi, Admin!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 50,
                ),
                _buildEmailTextField(context),
                _buildPasswordTextField(context),
                const SizedBox(
                  height: 26,
                ),
                Consumer<AdminLoginProvider>(
                    builder: (context, provider, child) {
                  return CustomLoadingButton(
                    callback: () {
                      if (_key.currentState!.validate()) {
                        logIn(provider);
                      }
                    },
                    loading: provider.isLoading,
                    btnName: "LogIn",
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                _buildDetailView()
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildDetailView() {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color(skyBlueShade),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              const Icon(
                Icons.manage_accounts_outlined,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "admin123@gmail.com",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.password_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "12345678",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              TextButton(
                  onPressed: autoFill,
                  child: const Text(
                    "Auto-Fill",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.brown,
          margin: const EdgeInsets.only(top: 40, left: 20),
          child: const Text(
            "Email",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 3),
              height: 50,
              decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.05000000074505806),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 3, right: 70),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (EmailValidator.validate(value!)) {
                    return null;
                  } else if (value.toString().isEmpty) {
                    return 'Required';
                  } else {
                    return 'Enter Valid Email';
                  }
                },
                decoration: InputDecoration(
                  errorStyle: GoogleFonts.poppins(),
                  hintText: "Enter your email address",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6000000238418579),
                      fontWeight: FontWeight.w400),
                  contentPadding: const EdgeInsets.only(left: 22, bottom: 2),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        // color: Colors.brown,
        margin: const EdgeInsets.only(top: 20, left: 20),
        child: const Text(
          "Password",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      Stack(children: [
        Container(
          margin: const EdgeInsets.only(left: 8, right: 8, top: 3),
          height: 50,
          decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.05000000074505806),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              )),
        ),
        Container(
          width: 300,
          margin: const EdgeInsets.only(left: 20, top: 3),
          child: TextFormField(
            obscureText: passwordVisible,
            controller: passController,
            validator: (value) {
              if (value.toString().isEmpty) {
                return 'Required';
              } else if (value.toString().length < 8) {
                return "Min length 8";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              errorStyle: GoogleFonts.poppins(),
              hintText: "Enter your password",
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.6000000238418579),
                  fontWeight: FontWeight.w400),
              contentPadding: const EdgeInsets.only(left: 22, bottom: 2),
              border: InputBorder.none,
            ),
          ),
        ),
        Positioned(
          top: 3,
          left: 310,
          child: IconButton(
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              icon: Icon(
                passwordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey,
              )),
        ),
      ])
    ]);
  }
}
