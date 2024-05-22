import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_employee/routes/app_routes.dart';
import 'package:the_employee/screens/admin_panel_screen/models/admin_panel_model.dart';
import 'package:the_employee/screens/admin_panel_screen/provider/admin_panel_provider.dart';
import 'package:the_employee/screens/employee_data_screen/models/employee_data_model.dart';
import 'package:the_employee/utils/color_constants.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    final provider = Provider.of<AdminPanelProvider>(context, listen: false);
    provider.fetchAllEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: _customFloatingButton(),
      appBar: AppBar(
        title: const Text(
          "Employee Details",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        actions: [
          Consumer<AdminPanelProvider>(builder: (context, provider, child) {
            return IconButton(
              icon: const Icon(
                Icons.refresh_outlined,
                color: Color(greyShade2),
                size: 30,
              ),
              onPressed: () async {
                await provider.fetchAllEmployeeData();
              },
            );
          }),
        ],
      ),
      body: _buildEmployeeTiles(),
    ));
  }

  Widget _customFloatingButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: const Color(lightPurple),
      child: const Icon(
        Icons.search_outlined,
        color: Colors.white,
      ),
    );
  }

  Widget greenOrRed(DateTime from, DateTime to, bool isActive) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    var res = (to.difference(from).inDays / 365).round();

    if (isActive == true) {
      if (res > 5) {
        return const CircleAvatar(
          child: Icon(
            Icons.verified,
            color: Colors.green,
          ),
        );
      }
    }
    return const CircleAvatar(
      child: Icon(
        Icons.verified_outlined,
        color: Colors.red,
      ),
    );
  }

  navigate(AdminPanelModel model) {
    EmployeeDataModel employeeDataModel = EmployeeDataModel(
        fullName: model.fullName,
        email: model.email,
        phone: model.phone,
        workDetails: model.workDetails,
        joinDate: model.joinDate,
        isActive: model.isActive,
        aboutMe: model.aboutMe,
        skills: model.skills);
    Navigator.pushNamed(context, RouteName.employeeDataScreen,
        arguments: {'data': employeeDataModel, 'primaryEmail': model.id});
  }

  Widget _buildEmployeeTiles() {
    return Consumer<AdminPanelProvider>(builder: (context, provider, child) {
      return ListView.builder(
          itemCount: provider.list.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  tileColor: const Color(skyBlueShade),
                  onTap: () {
                    navigate(provider.list[i]);
                  },
                  title: Text(
                    provider.list[i].fullName,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  subtitle: provider.list[i].isActive
                      ? const Text(
                          "Active",
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          "Not Active",
                          style: TextStyle(color: Colors.white),
                        ),
                  trailing: greenOrRed(provider.list[i].joinDate,
                      DateTime.now(), provider.list[i].isActive),
                  leading: const Icon(
                    Icons.person_2_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          });
    });
  }
}
