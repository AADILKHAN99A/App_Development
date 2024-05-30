import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_company/presentation/login_screen/controller/login_controller.dart';
import 'package:the_company/presentation/login_screen/models/login_model.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/image_strings.dart';
import '../../widgets/textfield_ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  LoginController controller = Get.put(LoginController());
  int? index;

  void validate() async {
    if (_formKey.currentState!.validate()) {
      LoginModel model = LoginModel(
          phone: controllerPhone.text.toString(),
          password: controllerPassword.text.toString());
      controller.loginUser(context, model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    CImages.blueBackgroundWithRoundBorderSquarePatterns),
                fit: BoxFit.cover)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: Center(
                    child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Image.asset(
                          CImages.whiteLogoWithText,
                        )),
                  ),
                ),
                _buildForegroundView(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForegroundView() {
    return Container(
      margin: const EdgeInsets.only(top: 100, left: 10, right: 10),
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
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CommonTextField(
                controller: controllerPhone,
                keyboardType: TextInputType.phone,
                prefixText: "+91",
                label: 'Please Enter your Phone',
                validator: (String? value) {
                  if (!GetUtils.isPhoneNumber(value!)) {
                    return "Please enter phone number.";
                  } else {
                    return null;
                  }
                },
              )),
          Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Obx(() => CommonTextField(
                    obscureText: !controller.visiblePassword.value,
                    label: 'Enter the password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.updateVisiblePassword(
                              !controller.visiblePassword.value);
                        },
                        icon: controller.visiblePassword.value
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    controller: controllerPassword,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password.";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 character.";
                      } else {
                        return null;
                      }
                    },
                  ))),
          Obx(() => Container(
                margin: const EdgeInsets.only(top: 20, right: 15, left: 15),
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: CColors.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                    onPressed: () async {
                      validate();
                    },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
              )),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/forgot');
                  },
                  child: const Column(
                    children: [
                      Text("Forgot",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                      Text("Password",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                    ],
                  )),
              const SizedBox(
                height: 30,
                child: VerticalDivider(
                  thickness: 2,
                  color: Color(0xff02054E),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/signup');
                  },
                  child: const Column(
                    children: [
                      Text("Create an",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                      Text("account",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                    ],
                  )),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 120),
            child: TextButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/about');
                },
                child: const Text(
                  "About",
                  style: TextStyle(color: CColors.primary),
                )),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerPhone.dispose();
    controllerPassword.dispose();
  }
}
