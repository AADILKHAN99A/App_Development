import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:the_employee/screens/home_screen/provider/home_provider.dart';
import 'package:the_employee/utils/color_constants.dart';
import 'package:the_employee/widgets/custom_elevated_button.dart';

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
              buttonTextStyle: TextStyle(color: Colors.white),
            );
          }),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                _buildFullNameTextField(),
                _buildEmailTextField(),
                _buildPhoneNumberTextField(),
                _buildFieldOfWorkTextField(),
                _buildDatePicker(),
                _buildAciveTab()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAciveTab() {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Column(
        children: [
          const SizedBox(height: 10,),
          DefaultTabController(
              length: 2,
              child: ButtonsTabBar(
                  onTap: (value) {
                    switch (value) {
                      case 0:
                        homeProvider.setActive(true);
                        break;
                      case 1:
                        homeProvider.setActive(false);
                        break;
                    }
                  },
                  backgroundColor: const Color(darkBlue),
                  labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),
                  tabs: const [
                    Tab(
                      text: " Active ",
                    ),
                    Tab(
                      text: " Not Active ",
                    ),
                  ])),
        ],
      );
    });
  }

  Widget _buildFullNameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 34, left: 20),
          child: Text(
            "Full Name",
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(darkBlue)),
          ),
        ),
        Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
            height: 50,
            decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.05000000074505806),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5, right: 40),
            child: TextFormField(
              controller: nameController,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Required';
                } else {
                  return null;
                }
              },
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
      ],
    );
  }

  Widget _buildPhoneNumberTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.brown,
          margin: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            "Phone Number",
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(darkBlue)),
          ),
        ),
        Stack(children: [
          Container(
              margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
              height: 50,
              decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.05000000074505806),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ))),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 20, right: 40, bottom: 30),
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
      ],
    );
  }

  Widget _buildFieldOfWorkTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Text(
            "Work Details",
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(darkBlue)),
          ),
        ),
        Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
            height: 50,
            decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.05000000074505806),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5, right: 40),
            child: TextFormField(
              controller: fieldController,
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
                hintText: "Enter Your Work Details",
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
      ],
    );
  }

  Widget _buildDatePicker() {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.brown,
            margin: const EdgeInsets.only(top: 40, left: 20),
            child: const Text(
              "Joining Date",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
                  "${homeProvider.selectedDate.day}/${homeProvider.selectedDate.month}/${homeProvider.selectedDate.year}")),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: CustomElevatedButton(
              onPressed: () {
                homeProvider.selectDate(context);
              },
              text: "Select Date",
              buttonTextStyle: const TextStyle(color: Colors.white),
              buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: const Color(darkBlue)),
            ),
          )
        ],
      );
    });
  }

  Widget _buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.brown,
          margin: const EdgeInsets.only(top: 10, left: 20),
          child: const Text(
            "Email",
            style: TextStyle(
                color: Color(darkBlue),
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
        ),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
              height: 50,
              decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.05000000074505806),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, right: 70),
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
}
