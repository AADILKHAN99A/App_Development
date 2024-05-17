import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:the_expenses/screens/login_screen/provider/login_provider.dart';
import '../../routes/routes.dart';
import '../../utils/image_constants.dart';
import '../../widgets/custom_loading_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'models/login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void googleLogIn() async {
    LogInProvider().userGoogleLogIn(context);
  }

  void logIn(LogInProvider provider) async {
    LoginModel model = LoginModel(emailController.text, passController.text);
    LogInProvider().signUserIn(model, context, provider);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                  "Hi, Welcome back!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomOutlinedButton(
                  onPressed: googleLogIn,
                  text: "Continue With Google",
                  leftIcon: Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Image.asset(googleImage, height: 23, width: 24),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 33, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: SizedBox(
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "or continue with",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Flexible(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: SizedBox(
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildEmailTextField(context),
                _buildPasswordTextField(context),
                const SizedBox(
                  height: 26,
                ),
                Consumer<LogInProvider>(builder: (context, provider, child) {
                  return CustomLoadingButton(
                    callback: () {
                      if (_key.currentState!.validate()) {
                        logIn(provider);
                      }
                    },
                    btnName: 'LogIn',
                    loading: provider.isLoading,
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.signUpScreen);
                        },
                        child: const Text("Sign up"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
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
    return Consumer<LogInProvider>(builder: (context, provider, child) {
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
              obscureText: provider.passwordVisible,
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
                  provider.togglePasswordVisibility();
                },
                icon: Icon(
                  provider.passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                )),
          ),
        ])
      ]);
    });
  }
}
