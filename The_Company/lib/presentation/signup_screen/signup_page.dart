import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_company/presentation/signup_screen/controller/signup_controller.dart';
import 'package:the_company/widgets/helper_widgets.dart';
import 'package:the_company/utils/color_schemes.dart';

import '../../widgets/textfield_ui.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({
    super.key,
    this.extra,
  });

  final String? extra;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.extra == null
        ? controllerInviteCode.text = ""
        : controllerInviteCode.text = widget.extra.toString();

    if (kDebugMode) {
      print(widget.extra);
    }

    setState(() {});
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  final GlobalKey<FormState> _formKeyPhone = GlobalKey();

  final FocusNode _focusNodeCode = FocusNode();
  final FocusNode _focusNodeInviteCode = FocusNode();
  final FocusNode _focusNodePhone = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();
  final TextEditingController controllerInviteCode = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  String smsCode = '';

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<bool?> validateAllFields() async {
    if (_formKeyPhone.currentState!.validate() &&
        _formKey.currentState!.validate()) {
      MessageDisplay().showMessage("Please wait...", context);

      controller.updateLoading(true);

      // validate otp and check status of verified or not
      bool isVerified = await controller.validateOtp(
          _codeController.text.toString(), context);
      return isVerified;
    }
    return null;
  }

  void validatePhone() async {
    if (_formKeyPhone.currentState!.validate()) {
      // check that user is already available or not
      controller.updateOtpLoading(true);
      await controller
          .isUserAvailable(phone: controllerPhone.text.toString())
          .then((available) async {
        // user is not registered
        if (available != true) {
          await controller.getOtp(controllerPhone, context);
        }

        // user is already registered
        else {
          MessageDisplay().showMessage("User Already Registered", context);
        }
        controller.updateOtpLoading(false);
      });
    }
  }

  SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/BlueBackground.jpg"),
                fit: BoxFit.cover)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/cwhitewithlogo.png',
                  scale: 1.2,
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKeyPhone,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CommonTextField(
                                label: "Please Enter your Phone",
                                controller: controllerPhone,
                                keyboardType: TextInputType.phone,
                                prefixText: "+91",
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter phone number.";
                                  } else if (value.length != 10) {
                                    return "Enter valid phone number.";
                                  } else {
                                    return null;
                                  }
                                },
                                onEditingComplete: () =>
                                    _focusNodePhone.requestFocus())),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: CommonTextField(
                                  controller: _codeController,
                                  focusNode: _focusNodeCode,
                                  keyboardType: TextInputType.phone,
                                  label: "Please Enter the Sms",
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter Sms.";
                                    }
                                    return null;
                                  },
                                  onEditingComplete: () =>
                                      _focusNodePassword.requestFocus(),
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Obx(() => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff02054E)),
                                onPressed: () {
                                  validatePhone();
                                },
                                child: controller.isOtpLoading == true
                                    ? Transform.scale(
                                        scale: 0.5,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        "Get code",
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ))),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CommonTextField(
                            controller: controllerPassword,
                            obscureText: _obscurePassword,
                            focusNode: _focusNodePassword,
                            keyboardType: TextInputType.visiblePassword,
                            label: "Enter the password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: _obscurePassword
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(
                                        Icons.visibility_off_outlined)),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter password.";
                              } else if (value.length < 8) {
                                return "Password must be at least 8 character.";
                              }
                              return null;
                            },
                            onEditingComplete: () =>
                                _focusNodeConfirmPassword.requestFocus(),
                          )),
                      const SizedBox(height: 10),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CommonTextField(
                            controller: _controllerConFirmPassword,
                            obscureText: _obscureConfirmPassword,
                            focusNode: _focusNodeConfirmPassword,
                            keyboardType: TextInputType.visiblePassword,
                            label: "Enter the confirm password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                                icon: _obscureConfirmPassword
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(
                                        Icons.visibility_off_outlined)),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter password.";
                              } else if (value != controllerPassword.text) {
                                return "Password doesn't match.";
                              }
                              return null;
                            },
                          )),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CommonTextField(
                          controller: controllerInviteCode,
                          keyboardType: TextInputType.phone,
                          label: "Enter invite code",
                          validator: (String? value) {
                            return null;
                          },
                          onEditingComplete: () =>
                              _focusNodeInviteCode.requestFocus(),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Obx(() => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: darkBlue,
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await validateAllFields()
                                        .then((isVerified) async {
                                      if (isVerified == true) {
                                        await controller.registerUser(
                                            controllerPhone.text.toString(),
                                            controllerPassword.text.toString(),
                                            controllerInviteCode.text
                                                .toString(),
                                            context);
                                        controller.updateLoading(false);
                                        Get.offAndToNamed('login');
                                      }
                                      controller.updateLoading(false);
                                    });
                                  },
                                  child: controller.isLoading == true
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Register",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                )),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, 'login'),
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodeCode.dispose();
    _focusNodeInviteCode.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    controllerPhone.dispose();
    controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    _formKey.currentState?.reset();
    super.dispose();
  }
}
