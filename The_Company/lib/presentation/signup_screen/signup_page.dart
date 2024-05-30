import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_company/presentation/signup_screen/controller/signup_controller.dart';
import 'package:the_company/presentation/signup_screen/models/signup_model.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/image_strings.dart';
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
    super.initState();
    widget.extra == null
        ? controllerInviteCode.text = ""
        : controllerInviteCode.text = widget.extra.toString();

    if (kDebugMode) {
      print(widget.extra);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  final GlobalKey<FormState> _formKeyPhone = GlobalKey();

  final FocusNode _focusNodeCode = FocusNode();
  final FocusNode _focusNodeInviteCode = FocusNode();
  final FocusNode _focusNodePhone = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeLastName = FocusNode();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();
  final TextEditingController controllerInviteCode = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  late SignupModel model;
  String smsCode = '';

  void setData() {
    model.phone = controllerPhone.text;
    model.password = controllerPassword.text;
    model.confirmPassword = _controllerConFirmPassword.text;
    model.sms = _smsController.text;
    model.inviteCode = controllerInviteCode.text;
  }

  void validateAllFields() async {
    if (_formKeyPhone.currentState!.validate() &&
        _formKey.currentState!.validate()) {
      setData();
      controller.initVerifiedOtpFeature(model, context);
    }
  }

  void validatePhone() async {
    if (_formKeyPhone.currentState!.validate()) {
      model = SignupModel(phone: controllerPhone.text);
      controller.initGetOtpFeature(model, context);
    }
  }

  SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration:  BoxDecoration(
            image: DecorationImage(
                image: AssetImage(CImages.blueBackgroundWithRoundBorderSquarePatterns),
                fit: BoxFit.cover)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  CImages.whiteLogoWithText,
                  scale: 1.2,
                ),
                const SizedBox(height: 30),
                _buildForegroundView(),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForegroundView() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          _buildNameFields(),
          Form(
            key: _formKeyPhone,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CommonTextField(
                    label: "Phone Number",
                    controller: controllerPhone,
                    keyboardType: TextInputType.phone,
                    prefixText: "+91",
                    prefixIcon: const Icon(Icons.call),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter phone number.";
                      } else if (value.length != 10) {
                        return "Enter valid phone number.";
                      } else {
                        return null;
                      }
                    },
                    onEditingComplete: () => _focusNodePhone.requestFocus())),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CommonTextField(
                      controller: _smsController,
                      focusNode: _focusNodeCode,
                      keyboardType: TextInputType.phone,
                      label: "Sms Code",
                      prefixIcon: const Icon(Icons.sms_outlined),
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
                    onPressed: validatePhone,
                    child: controller.isOtpLoading.value == true
                        ? Transform.scale(
                            scale: 0.5,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Get code",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ))),
              )
            ],
          ),
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(() => CommonTextField(
                    controller: controllerPassword,
                    obscureText: !controller.visiblePassword.value,
                    focusNode: _focusNodePassword,
                    keyboardType: TextInputType.visiblePassword,
                    label: "Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.updateVisiblePassword(
                            !controller.visiblePassword.value,
                          );
                        },
                        icon: !controller.visiblePassword.value
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    prefixIcon: const Icon(Icons.password_outlined),
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
                  ))),
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(() => CommonTextField(
                    controller: _controllerConFirmPassword,
                    obscureText: !controller.visibleConfirmPassword.value,
                    focusNode: _focusNodeConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    label: "Confirm Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.updateVisibleConfirmPassword(
                              !controller.visibleConfirmPassword.value);
                        },
                        icon: !controller.visibleConfirmPassword.value
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    prefixIcon: const Icon(Icons.password_outlined),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password.";
                      } else if (value != controllerPassword.text) {
                        return "Password doesn't match.";
                      }
                      return null;
                    },
                  ))),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CommonTextField(
              controller: controllerInviteCode,
              keyboardType: TextInputType.phone,
              label: "Invite Code",
              prefixIcon: const Icon(Icons.numbers),
              validator: (String? value) {
                return null;
              },
              onEditingComplete: () => _focusNodeInviteCode.requestFocus(),
            ),
          ),
          const SizedBox(height: 10),
          _buildTermsAndConditionView(),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CColors.primary,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: validateAllFields,
                      child: controller.isLoading.value == true
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
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditionView() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(() => Flexible(
              child: Checkbox(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  value: controller.checkedTAC.value,
                  onChanged: (value) {
                    controller.updateCheckedTAC(!controller.checkedTAC.value);
                  }),
            )),
        const Text("I agree to Privacy Policy and terms of use")
      ],
    );
  }

  Widget _buildNameFields() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CommonTextField(
                label: "First Name",
                controller: firstNameController,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.person_2_outlined),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter first name.";
                  } else {
                    return null;
                  }
                },
                onEditingComplete: () => _focusNodeFirstName.requestFocus()),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: CommonTextField(
                label: "Last Name",
                controller: lastNameController,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.person_2_outlined),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter first name.";
                  } else {
                    return null;
                  }
                },
                onEditingComplete: () => _focusNodeLastName.requestFocus()),
          ),
        ],
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
