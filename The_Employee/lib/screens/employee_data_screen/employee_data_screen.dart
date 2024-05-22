import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:the_employee/screens/employee_data_screen/provider/employee_data_provider.dart';
import 'package:the_employee/utils/color_constants.dart';
import 'package:the_employee/utils/image_constants.dart';

class EmployeeDataScreen extends StatefulWidget {
  final Map args;

  const EmployeeDataScreen({super.key, required this.args});

  @override
  State<EmployeeDataScreen> createState() => _EmployeeDataScreenState();
}

class _EmployeeDataScreenState extends State<EmployeeDataScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    var provider = Provider.of<EmployeeDataProvider>(context, listen: false);
    provider.initEmpData(widget.args['data'], widget.args['primaryEmail']);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeDataProvider>(builder: (context, provider, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            "My Profile",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              )),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  provider.editDetails(context);
                },
                icon: const FaIcon(FontAwesomeIcons.penToSquare,
                    color: Colors.white))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _imageView(provider),
              _joinDateView(provider),
              _aboutMeView(provider),
              _skillsView(provider)
            ],
          ),
        ),
      );
    });
  }

  Widget _joinDateView(EmployeeDataProvider provider) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: BoxDecoration(
        color: const Color(lightPurpleShade),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.date_range_outlined,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            DateFormat('dd/MM/yyyy')
                .format(provider.employeeDataModel.joinDate),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _aboutMeView(EmployeeDataProvider provider) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About Me",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              provider.employeeDataModel.aboutMe ?? "",
              style: const TextStyle(color: Color(greyShade)),
            )
          ],
        ),
      ),
    );
  }

  Widget _skillsView(EmployeeDataProvider provider) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "Skill",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.employeeDataModel.skills.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Color(index % 2 == 0
                            ? lightPurpleShade
                            : index % 3 == 0
                                ? lightPink
                                : lightSkyBlue),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          provider.employeeDataModel.skills[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailsView(EmployeeDataProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          provider.employeeDataModel.fullName.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        provider.employeeDataModel.isActive == true
            ? const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Active",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.verified_user,
                    color: Colors.green,
                  )
                ],
              )
            : const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not Active",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.red,
                  )
                ],
              ),
        const SizedBox(
          height: 20,
        ),
        Text(
          provider.employeeDataModel.workDetails.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _personalDetailsView(EmployeeDataProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              provider.showDetails(context, DialogType.email);
            },
            icon: const Icon(Icons.email_outlined),
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              provider.showDetails(context, DialogType.phone);
            },
            icon: const Icon(
              Icons.phone,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageView(EmployeeDataProvider provider) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.maxFinite,
          color: const Color(lightPurple),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 18,
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      profileBg,
                      height: 300,
                      fit: BoxFit.fill,
                      width: double.maxFinite,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(darkPurple),
                        radius: 50,
                        child: Image.asset(userImage),
                      ),
                      _detailsView(provider),
                      _personalDetailsView(provider)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
