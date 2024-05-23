import 'package:flutter/Material.dart';
import 'package:the_employee/screens/admin_panel_screen/provider/admin_panel_provider.dart';

import '../utils/color_constants.dart';

class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet(
      {super.key,
      required this.controller,
      required this.provider,
      required this.onChanged});

  final TextEditingController controller;
  final AdminPanelProvider provider;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildBackgroundView(context), _buildListView(provider)],
    );
  }

  Widget _buildListView(AdminPanelProvider provider) {
    return Expanded(
      child: ListView.builder(
          itemCount: provider.searchedList.length,
          itemBuilder: (context, index) {
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
                    provider.navigate(context, provider.list[index]);
                    controller.clear();
                  },
                  title: Text(
                    provider.searchedList[index].fullName,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  subtitle: provider.searchedList[index].isActive
                      ? const Text(
                          "Active",
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          "Not Active",
                          style: TextStyle(color: Colors.white),
                        ),
                  trailing: greenOrRed(provider.searchedList[index].joinDate,
                      DateTime.now(), provider.searchedList[index].isActive),
                  leading: const Icon(
                    Icons.person_2_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
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

  Widget _buildBackgroundView(BuildContext context) {
    return Container(
      height: 160,
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Color(lightPurple),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_outlined),
                hintText: "Search..",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
