import 'package:get/get.dart';
import 'package:the_company/controllers/init_controller.dart';
import 'package:the_company/database/models/register_user.dart';

class Init {
  final UserData userData;

  InitController controller = Get.put(InitController());
  Init(this.userData);

  void getData()async{
    controller.updateLoading(true);

    // update userdata value
    controller.updateUserData(userData);

    print(controller.userData.value.phone);

    controller.updateLoading(false);


    //   if (walletData["rent"] != null) {
    //     for (int i = 1; i <= walletData["rent"].length; i++) {
    //       await RealtimeDatabase.fetchPackageActivationDetails(
    //           walletId: data["userid"],
    //           transid: walletData["rent"]["rent$i"]["transid"],
    //           amount: walletData["rent"]["rent$i"]["amount"],
    //           date: walletData["rent"]["rent$i"]["date"])
    //           .then((value) {
    //         if (value == true) {
    //           print("Rent Write Perform");
    //           RealtimeDatabase.rentWrite(
    //               userId: widget.userid,
    //               amount: walletData["rent"]["rent$i"]["amount"],
    //               dailyincome: walletData["rent"]["rent$i"]["dailyincome"],
    //               walletId: data["userid"],
    //               datetime: DateTime.now(),
    //               transid: walletData["rent"]["rent$i"]["transid"],
    //               totalincome: walletData["rent"]["rent$i"]["totalincome"]);
    //         }
    //       });
    //     }
    //   }
    //
    //   total = 0;
    //   todayIncome = 0;
    //   totalIncome = 0;
    //   totalwithdrawl = 0;
    //   for (int i = 1; i <= data["rent"].length; i++) {
    //     total = total + data["rent"]["transaction$i"]["amount"];
    //     todayIncome = todayIncome + data["rent"]["transaction$i"]["dailyincome"];
    //     // totalIncome = totalIncome + data["rent"]["transaction$i"]["totalincome"];
    //   }
    //   for (int i = 1; i <= walletData["withdrawl"].length; i++) {
    //     totalwithdrawl = totalwithdrawl + walletData["withdrawl"]["amount$i"];
    //   }
    //   totalIncome = walletData["balance"] + totalwithdrawl;
    //   inviteData = await RealtimeDatabase.fetchInvite(userId: data["userid"]);
    //   setState(() {});
  }
}