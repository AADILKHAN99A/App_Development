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

  TextEditingController aboutController = TextEditingController();

  TextEditingController skillsController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void write(HomeProvider provider) {
    if (_key.currentState!.validate()) {
      provider.writeData(
          email: emailController.text.toString(),
          phone: phoneController.text.toString(),
          fullName: nameController.text.toString(),
          workDetails: fieldController.text.toString(),
          primaryEmail: widget.args['id'],
          context: context,
          aboutMe: aboutController.text.toString());
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
                  ElevatedButton.styleFrom(backgroundColor: Color(darkPurple)),
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
                _buildActiveTab(),
                _aboutMeView(),
                _buildSkillsTextFieldView(),
                _buildSkillsListView(),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _aboutMeView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 34, left: 20),
          child: Text(
            "About Me",
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(darkPurple)),
          ),
        ),
        Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
            height: 140,
            decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.05000000074505806),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5, right: 40),
            child: TextFormField(
              controller: aboutController,
              maxLines: 5,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Required';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                errorStyle: GoogleFonts.poppins(),
                hintText: "About Me",
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6000000238418579),
                    fontWeight: FontWeight.w400),
                contentPadding: const EdgeInsets.only(left: 22),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.text,
            ),
          ),
        ]),
      ],
    );
  }

  Widget _buildSkillsListView() {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: provider.skills.length,
          itemBuilder: (context, index) {
            return Center(
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  color: const Color(skyBlueShade),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      provider.skills[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        provider.removeSkill(provider.skills[index]);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 10,
            );
          },
        ),
      );
    });
  }

  Widget _buildSkillsTextFieldView() {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 34, left: 20),
            child: Text(
              "Skills",
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(darkPurple)),
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
              padding: const EdgeInsets.only(left: 20, top: 2, right: 40),
              child: TextFormField(
                controller: skillsController,
                validator: (value) {
                  if (provider.skills.isEmpty) {
                    return 'Add atleast one';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  suffix: IconButton(
                    onPressed: () {
                      provider.addSkill(skillsController.text.toString());
                      skillsController.clear();
                    },
                    icon: const Icon(Icons.add),
                  ),
                  errorStyle: GoogleFonts.poppins(),
                  hintText: "Enter Skills",
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
    });
  }

  Widget _buildActiveTab() {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
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
                  backgroundColor: const Color(skyBlueShade),
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
                color: const Color(darkPurple)),
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
                color: const Color(darkPurple)),
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
                color: const Color(darkPurple)),
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
                  backgroundColor: const Color(darkPurple)),
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
                color: Color(darkPurple),
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