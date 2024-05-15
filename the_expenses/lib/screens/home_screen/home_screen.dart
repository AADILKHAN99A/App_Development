
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses/screens/home_screen/provider/home_provider.dart';

import '../../utils/color_constants.dart';
import '../../widgets/custom_elevated_button.dart';


class HomeScreen extends StatefulWidget {
  final Map args;

  const HomeScreen({super.key, required this.args});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fieldController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void write(HomeProvider provider) {
    if (_key.currentState!.validate()) {
      provider.writeData(
          email: emailController.text.toString(),
          phone: phoneController.text.toString(),
          fullName: nameController.text.toString(),
          workDetails: fieldController.text.toString(),
          primaryEmail: widget.args['id'],
          context: context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("arguments: ${widget.args}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Consumer<HomeProvider>(builder: (context, homeProvider, child) {
            return CustomElevatedButton(
              onPressed: () {
                write(homeProvider);
              },
              text: "Submit",
              buttonStyle:
                  ElevatedButton.styleFrom(backgroundColor: Color(darkBlue)),
              buttonTextStyle: const TextStyle(color: Colors.white),
            );
          }),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [

              ],
            ),
          ),
        ),
      ),
    );
  }





}
