import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/database_helper.dart';
import 'package:survey/firebase_auth%20implementation/firebase_auth%20services.dart';
import 'package:survey/firebase_database/firebase_db_helper.dart';
import 'package:survey/survey_list.dart';
import 'package:survey/widgets/squaretile.dart';
import 'package:survey/widgets/toast.dart';
import 'package:survey/widgets/widgets.dart';
import 'package:survey/signup_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Login> {
  //.............VARIABLE DECLARATION..............
  String email = '';
  String password = '';
  bool passwordVisible = true;
  final mainKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool emailValidate = false, passValidate = false;
  FToast? fToast;

  bool isLoading = false;

  //..............FUNCTIONS........................

  Future signUserIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passController.text.trim())
          .then((credential) async {
        print("Credentials is $credential");
        setState(() {
          isLoading = false;
        });

        await DatabaseHelper.instance
            .findUser(uid: credential.user?.uid)
            .then((value) async {
          if (value.isNotEmpty) {
            print(value);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) => SurveyList(
                          id: credential.user?.uid,
                        )));
          } else {
            print("User is only on Server not local");
            await DatabaseHelper.instance
                .insertUser(
                    userid: credential.user?.uid, email: credential.user?.email)
                .then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) =>
                            SurveyList(id: credential.user?.uid))));
          }
        });
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      isLoading = false;
      setState(() {});
      if (e.code == 'invalid-email') {
        showToast(message: "No user found for that email");
        if (kDebugMode) {
          print("No user found for that email");
        }
      } else if (e.code == 'invalid-password') {
        showToast(message: "User password is Incorrect");
        if (kDebugMode) {
          print("User password is Incorrect");
        }
      } else if (e.code == 'invalid-credential') {
        showToast(message: "User Credentials is Invalid");
        if (kDebugMode) {
          print("User Credentials is Invalid");
        }
      } else if (e.code == 'too-many-requests') {
        showToast(
            message: "Account is Temporarily disable due to too many attempts");
        if (kDebugMode) {
          print("Account is Temporarily disable due to too many attempts");
        }
      } else if (e.code == 'user-not-found') {
        showToast(message: "User is not found,Please Create Account");
        if (kDebugMode) {
          print("User Not found");
        }
      }
    }
  }

  showCustomToast() {
    Widget toast = Container(
      margin: const EdgeInsets.only(bottom: 35),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black.withOpacity(0.30000000074505806),
      ),
      child: const Text(
        "Wrong Details",
        style: TextStyle(color: Colors.white),
      ),
    );

    fToast?.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
    );
  }

  trySubmit() {
    final isValid = mainKey.currentState!.validate();
    if (isValid) {
      mainKey.currentState!.save();
      return submitForm();
    } else {
      if (kDebugMode) {
        print("Error ");
      }
    }
  }

  submitForm() {
    if (kDebugMode) {
      print(email);
    }
    if (kDebugMode) {
      print(password);
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    fToast?.init(context);
    // emailController.dispose();
    // passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Form(
          key: mainKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 42,
                margin: const EdgeInsets.only(top: 80, left: 24),
                child: Text(
                  "Welcome Back !",
                  style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.53),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 24),
                alignment: Alignment.topLeft,
                child: Text(
                  "Enter Your Email & Password",
                  style: GoogleFonts.poppins(
                      color: Colors.black.withOpacity(0.6000000238418579),
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Container(
                // color: Colors.brown,
                margin: const EdgeInsets.only(top: 76, left: 20),
                child: const Text(
                  "Email",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 3),
                    height: 50,
                    decoration: ShapeDecoration(
                        color: Colors.black.withOpacity(0.05000000074505806),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 3, right: 70),
                    child: TextFormField(
                      controller: emailController,
                      key: ValueKey(email),
                      validator: (value) {
                        if (EmailValidator.validate(value!)) {
                          return null;
                        } else if (value.toString().isEmpty) {
                          return 'Required';
                        } else {
                          return 'Enter Valid Email';
                        }
                      },
                      onSaved: (value) {
                        email = value.toString();
                      },
                      decoration: InputDecoration(
                        errorStyle: GoogleFonts.poppins(),
                        hintText: "Enter your email address",
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
                ],
              ),
              Container(
                // color: Colors.brown,
                margin: const EdgeInsets.only(top: 20, left: 20),
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
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(left: 20, top: 3),
                  child: TextFormField(
                    obscureText: passwordVisible,
                    key: ValueKey(password),
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
                    onSaved: (value) {
                      password = value.toString();
                    },
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
                margin: const EdgeInsets.only(top: 20),
                child: Button(
                  loading: isLoading,
                  btnName: "Log In",
                  callback: () async {
                    if (trySubmit() == true) {
                      isLoading = true;
                      setState(() {});

                      signUserIn();
                    } else {
                      showCustomToast();
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: const Center(child: Text("Don't have an account?")),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Button(
                  btnName: "Sign Up",
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 35, left: 10, right: 10),
                child: const Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                    )),
                    Text("Or continue with"),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath: "assets/icons/googlelogo.png",
                      onTap: () => FirebaseAuthServices()
                          .signInWithGoogle()
                          .then((credential) async {
                        if (credential != null) {
                          await FirebaseDatabaseService()
                              .getUser(uid: (credential).user.uid)
                              .then((value) async {
                            if (value == "User not found!") {
                              await FirebaseDatabaseService()
                                  .addUser(
                                      fullName: (credential).user.displayName,
                                      email: (credential).user.email,
                                      phone: (credential).user.phoneNumber,
                                      password: null,
                                      uid: (credential).user.uid)
                                  .then((value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => SurveyList(
                                              id: (credential).user.uid))));
                            } else {
                              await DatabaseHelper.instance
                                  .findUser(uid: (credential).user.uid)
                                  .then((value) async {
                                if (value == []) {
                                  await DatabaseHelper.instance
                                      .insertUser(
                                          userid: (credential).user.uid,
                                          email: (credential).user.email)
                                      .then((value) =>
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      SurveyList(
                                                          id: (credential)
                                                              .user
                                                              .uid))));
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => SurveyList(
                                              id: (credential).user.uid)));
                                }
                              });
                            }
                          });
                        }
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
