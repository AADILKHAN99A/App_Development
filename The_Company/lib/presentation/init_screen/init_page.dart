import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'dart:async';
import 'package:the_company/presentation/init_screen/controller/init_controller.dart';
import 'package:the_company/utils/color_schemes.dart';

class InitPage extends StatefulWidget {
  const InitPage({
    super.key,
    required this.args,
  });

  final Map args;

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  TabController? tabController;
  Timer? timer;

  InitController controller = Get.put(InitController());

  @override
  void initState() {
    super.initState();

    controller.getData(widget.args['userData']);
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    // refreshList();
    // timer = Timer.periodic(
    //   const Duration(hours: 24),
    //       (timer) {
    //     if (todayIncome > 0) {
    //       RealtimeDatabase.walletWrite(
    //           walletId: data["userid"],
    //           writeField: "balance",
    //           amount: todayIncome,
    //           dailyincome: todayIncome);
    //     }
    //     setState(() {});
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ConvexAppBar(
            onTap: (int i) {},
            controller: tabController,
            backgroundColor: Colors.white,
            color: Colors.blue,
            activeColor: darkBlue,
            initialActiveIndex: 0,
            items: [
              TabItem(icon: Icons.home, title: "home".tr),
              TabItem(icon: Icons.shopping_bag_outlined, title: "brands".tr),
              const TabItem(
                icon: Icons.ios_share,
              ),
              TabItem(icon: Icons.auto_graph, title: "income".tr),
              TabItem(icon: Icons.person, title: "user".tr)
            ]),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xff02054E),
          title: tabController?.index == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "The Company",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            tabController!.index = 4;
                          });
                          tabController?.animateTo(tabController!.index);
                        },
                        icon: const Icon(
                          Icons.person_2_outlined,
                          color: Colors.white,
                        ))
                  ],
                )
              : tabController?.index == 1
                  ? const Text("The Brands",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white))
                  : tabController?.index == 2
                      ? const Text("Share",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white))
                      : tabController?.index == 3
                          ? const Text("Income",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))
                          : const Text(
                              "User",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
        ),
        body: Obx(() => controller.isLoading == true
            ? Center(
                child: Image.asset(
                  'assets/loading2.gif',
                  scale: 4,
                ),
              )
            : TabBarView(controller: tabController, children: [
                // Home(
                //   callback: () {
                //     setState(() {
                //       tabController!.index = 2;
                //     });
                //     tabController?.animateTo(tabController!.index);
                //   },
                //   rechargeCallBack: () {
                //     setState(() {
                //       tabController!.index = 1;
                //     });
                //     tabController?.animateTo(tabController!.index);
                //   },
                //   withdrawlCallBack: () {
                //     setState(() {
                //       tabController!.index = 4;
                //     });
                //     tabController?.animateTo(tabController!.index);
                //   },
                //   phone: data['phone'],
                // ),
                // RentPage(
                //   id: data['phone'],
                //   userid: data['userid'],
                //   dailyincome: todayIncome,
                //   phone: data["phone"],
                // ),
                // Invite(
                //   code: data["userid"],
                //   invitedata: inviteData,
                //   commision: walletData["income"]["amount"],
                //   phone: widget.userid,
                // ),
                // IncomePage(
                //   data: data["rent"],
                //   requestData: requestData,
                // ),
                // UserPage(
                //   number: data["phone"],
                //   usid: data["userid"],
                //   rentlist: data["rent"],
                //   total: total,
                //   callback: () {
                //     setState(() {
                //       tabController!.index = 1;
                //     });
                //     tabController?.animateTo(tabController!.index);
                //   },
                //   totalIncome: totalIncome,
                //   todayIncome: todayIncome,
                //   walletData: walletData,
                //   inviteData: inviteData,
                //   totalwithdrawl: totalwithdrawl,
                // )
              ])));
  }
}
