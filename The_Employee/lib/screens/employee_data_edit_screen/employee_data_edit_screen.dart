import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:the_employee/screens/employee_data_edit_screen/provider/employee_data_edit_provider.dart';
import 'package:the_employee/screens/employee_data_screen/models/employee_data_model.dart';
import 'package:the_employee/screens/home_screen/models/home_model.dart';

import '../../utils/color_constants.dart';
import '../../widgets/custom_elevated_button.dart';
import '../home_screen/provider/home_provider.dart';

class EmployeeDataEditScreen extends StatefulWidget {
  const EmployeeDataEditScreen({super.key, required this.args});

  final Map args;

  @override
  State<EmployeeDataEditScreen> createState() => _EmployeeDataEditScreenState();
}

class _EmployeeDataEditScreenState extends State<EmployeeDataEditScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.args['data'].fullName);
    print(widget.args['primaryEmail']);
    model = widget.args['data'];

    nameController.text = model.fullName.toString();
    emailController.text = model.email.toString();
    phoneController.text = model.phone.toString();
    fieldController.text = model.workDetails.toString();
    setDate();
  }

  late HomeModel model;

  setDate() {
    Provider.of<EmployeeDataEditProvider>(context, listen: false).selectedDate =
        model.joinDate;

    Provider.of<EmployeeDataEditProvider>(context, listen: false).isActive =
        model.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<EmployeeDataEditProvider>(
          builder: (context, provider, child) {
        return CustomElevatedButton(
          onPressed: () {
            provider.writeData(
                email: emailController.text,
                phone: phoneController.text,
                fullName: nameController.text,
                workDetails: fieldController.text,
                primaryEmail: widget.args['primaryEmail'],
                context: context);
          },
          text: 'Update',
          buttonTextStyle: const TextStyle(color: Colors.white),
          buttonStyle:
              ElevatedButton.styleFrom(backgroundColor: const Color(darkBlue)),
        );
      }),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Edit Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFullNameTextField(),
          _buildEmailTextField(),
          _buildPhoneNumberTextField(),
          _buildFieldOfWorkTextField(),
          _buildDatePicker(),
          _buildAciveTab()
        ],
      ),
    );
  }

  Widget _buildAciveTab() {
    return Consumer<EmployeeDataEditProvider>(
        builder: (context, homeProvider, child) {
      return Column(
        children: [
          const SizedBox(height: 10),
          DefaultTabController(
              initialIndex: homeProvider.isActive == true ? 0 : 1,
              length: 2,
              child: ButtonsTabBar(
                  onTap: (value) {
                    switch (value) {
                      case 0:
                        homeProvider.isActive = true;
                        break;
                      case 1:
                        homeProvider.isActive = false;
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
    return Consumer<EmployeeDataEditProvider>(
        builder: (context, homeProvider, child) {
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
