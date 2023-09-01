import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/survey_list.dart';
import 'package:survey/widgets/widgets.dart';

void main() {
  runApp(const Survey());
}

class Survey extends StatelessWidget {
  const Survey({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.grey, selectionHandleColor: Colors.black),
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      routes: {
        '/surveyList': (context) => const SurveyList(),
      },
      home: const Login(),
    );
  }
}

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

  //..............FUNCTIONS........................

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
  void dispose() {
    emailController.dispose();
    super.dispose();
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
                      key: ValueKey(email),
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Please enter email!';
                        } else {
                          return null;
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
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Required';
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
                  left: 326,
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
                  btnName: "Log In",
                  callback: () {
                    if (trySubmit()) {
                      setState(() {
                        Navigator.pushNamed(context, '/surveyList');
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
