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
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void clearField() {

    controller.clear();
  }

  void refresh() async {
    final provider = Provider.of<AdminPanelProvider>(context, listen: false);
    provider.fetchAllEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Consumer<AdminPanelProvider>(builder: (context, provider, child) {
      return Scaffold(
        floatingActionButton:
            provider.isSearching ? null : _customFloatingButton(),
        appBar: provider.isSearching
            ? _buildSearchView(provider)
            : AppBar(
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
                  IconButton(
                    icon: const Icon(
                      Icons.refresh_outlined,
                      color: Color(greyShade2),
                      size: 30,
                    ),
                    onPressed: () async {
                      await provider.fetchAllEmployeeData();
                    },
                  )
                ],
              ),
        body: _buildEmployeeTiles(),
      );
    }));
  }

  PreferredSizeWidget? _buildSearchView(AdminPanelProvider provider) {
    return AppBar(
      flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            onChanged: (String query) {
              provider.searchList(controller.text.toString());
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                ),
                hintText: "Search..",
                hintStyle: const TextStyle(color: Colors.white),
                fillColor: const Color(lightPurple),
                suffix: IconButton(
                    onPressed: () {
                      clearField();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    )),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          )),
      automaticallyImplyLeading: false,
      leading: Container(
        margin: const EdgeInsets.only(right: 15),
        child: IconButton(
            onPressed: () {
              provider.toggleSearching();
              clearField();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
    );
  }

  Widget _customFloatingButton() {
    return Consumer<AdminPanelProvider>(builder: (context, provider, child) {
      return FloatingActionButton(
        onPressed: () {
          provider.toggleSearching();
        },
        backgroundColor: const Color(lightPurple),
        child: const Icon(
          Icons.search_outlined,
          color: Colors.white,
        ),
      );
    });
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

  Widget _buildEmployeeTiles() {
    return Consumer<AdminPanelProvider>(builder: (context, provider, child) {
      return provider.isSearching
          ? _buildSearchListTiles(provider)
          : ListView.builder(
              itemCount: provider.list.length,
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      tileColor: const Color(skyBlueShade),
                      onTap: () {
                        provider.navigate(context, provider.list[i]);
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

  Widget _buildSearchListTiles(AdminPanelProvider provider) {
    return Consumer<AdminPanelProvider>(builder: (context, provider, child) {
      return ListView.builder(
          itemCount: provider.searchedList.length,
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
                    provider.navigate(context, provider.searchedList[i]);
                  },
                  title: Text(
                    provider.searchedList[i].fullName,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  subtitle: provider.searchedList[i].isActive
                      ? const Text(
                          "Active",
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          "Not Active",
                          style: TextStyle(color: Colors.white),
                        ),
                  trailing: greenOrRed(provider.searchedList[i].joinDate,
                      DateTime.now(), provider.searchedList[i].isActive),
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
