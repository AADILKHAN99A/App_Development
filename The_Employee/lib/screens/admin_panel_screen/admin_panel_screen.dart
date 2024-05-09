import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_employee/routes/app_routes.dart';
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
    final provider = Provider.of<AdminPanelProvider>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Employee Details"),
        centerTitle: true,
        actions: [
          Consumer<AdminPanelProvider>(builder: (context, provider, child) {
            print(provider.list);
            return IconButton(
              icon: const Icon(Icons.refresh),
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

  Widget greenOrRed(DateTime from, DateTime to, bool isActive) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    var res = (to.difference(from).inDays / 365).round();

    if (isActive == true) {
      if (res > 5) {
        return const Icon(
          Icons.verified,
          color: Colors.green,
        );
      }
    }
    return const Icon(
      Icons.verified_outlined,
      color: Colors.red,
    );
  }

  navigate(EmployeeDataModel model) {
    Navigator.pushNamed(context, RouteName.employeeDataScreen,
        arguments: {'data': model});
  }

  Widget _buildEmployeeTiles() {
    return Consumer<AdminPanelProvider>(builder: (context, provider, child) {
      return ListView.builder(
          itemCount: provider.list.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Card(
                child: ListTile(
                  onTap: () {
                    navigate(provider.list[i]);
                  },
                  title: Text(
                    provider.list[i].fullName,
                    style: const TextStyle(color: Color(darkBlue)),
                  ),
                  subtitle: provider.list[i].isActive
                      ? const Text("Active")
                      : const Text("Not Active"),
                  trailing: greenOrRed(provider.list[i].joinDate,
                      DateTime.now(), provider.list[i].isActive),
                  leading: const Icon(
                    Icons.person_2_outlined,
                    color: Color(darkBlue),
                  ),
                ),
              ),
            );
          });
    });
  }
}
