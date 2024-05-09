import 'package:email_validator/email_validator.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:the_employee/screens/signup_screen/models/signup_model.dart';
import 'package:the_employee/screens/signup_screen/provider/signup_provider.dart';
import 'package:the_employee/widgets/custom_loading_button.dart';

import '../../routes/app_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 34, left: 20),
                  child: Text(
                    "Name",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Stack(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 3, left: 20, right: 20),
                    height: 50,
                    decoration: ShapeDecoration(
                        color: Colors.black.withOpacity(0.05000000074505806),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 3, right: 40),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {},
                      decoration: InputDecoration(
                        errorStyle: GoogleFonts.poppins(),
                        hintText: "Enter name",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.6000000238418579),
                            fontWeight: FontWeight.w400),
                        contentPadding: const EdgeInsets.only(left: 22),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ]),
                Container(
                  // color: Colors.brown,
                  margin: const EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    "Email",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Stack(children: [
                  Container(
                      margin:
                          const EdgeInsets.only(top: 3, left: 20, right: 20),
                      height: 50,
                      decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.05000000074505806),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 3, right: 40),
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
                      onSaved: (value) {},
                      decoration: InputDecoration(
                        errorStyle: GoogleFonts.poppins(),
                        hintText: "Enter email",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.6000000238418579),
                            fontWeight: FontWeight.w400),
                        contentPadding: const EdgeInsets.only(left: 22),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ]),
                Container(
                  // color: Colors.brown,
                  margin: const EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    "Phone Number",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Stack(children: [
                  Container(
                      margin:
                          const EdgeInsets.only(top: 3, left: 20, right: 20),
                      height: 50,
                      decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.05000000074505806),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 3, left: 20, right: 40, bottom: 30),
                    child: TextFormField(
                      controller: phoneController,
                      maxLength: 15,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Required';
                        } else if (!RegExp(
                                r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                            .hasMatch(value!)) {
                          return "Enter Valid Mobile Number";
                        }
                        return null;
                      },
                      onSaved: (value) {},
                      decoration: InputDecoration(
                        counter: const SizedBox.shrink(),
                        errorStyle: GoogleFonts.poppins(),
                        hintText: "Enter Phone number",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.6000000238418579),
                            fontWeight: FontWeight.w400),
                        contentPadding: const EdgeInsets.only(left: 22),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ]),
                Container(
                  // color: Colors.brown,
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Stack(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 3),
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
                      controller: passwordController,
                      obscureText: passwordVisible,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Required';
                        } else if (value.toString().length < 8) {
                          return "Min length 8";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {},
                      decoration: InputDecoration(
                        errorStyle: GoogleFonts.poppins(),
                        hintText: "Enter your password",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.6000000238418579),
                            fontWeight: FontWeight.w400),
                        contentPadding:
                            const EdgeInsets.only(left: 22, bottom: 2),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 3,
                    left: 335,
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
                ]),
                Container(
                  // color: Colors.brown,
                  margin: const EdgeInsets.only(top: 20, left: 20),
                  child: const Text(
                    "Confirm Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Stack(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 3),
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
                      controller: confirmPasswordController,
                      obscureText: confirmPasswordVisible,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Required';
                        } else if (value != passwordController.text) {
                          return "Password doesn't match";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {},
                      decoration: InputDecoration(
                        errorStyle: GoogleFonts.poppins(),
                        hintText: "Confirm password",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.6000000238418579),
                            fontWeight: FontWeight.w400),
                        contentPadding:
                            const EdgeInsets.only(left: 22, bottom: 2),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 3,
                    left: 335,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          });
                        },
                        icon: Icon(
                          confirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        )),
                  ),
                ]),
                Consumer<SignUpProvider>(builder: (context, provider, child) {
                  return Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: CustomLoadingButton(
                      loading: provider.isLoading,
                      btnName: "Create Account",
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          signUp(provider);
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ));
  }

  void signUp(SignUpProvider provider) async {
    SignUpModel model = SignUpModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text);
    await SignUpProvider().userSignUp(model, provider).then((isNavigate) {
      if (isNavigate == true) {
        Navigator.pushReplacementNamed(context, RouteName.homeScreen,
            arguments: {'data': model, 'id': model.email});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
