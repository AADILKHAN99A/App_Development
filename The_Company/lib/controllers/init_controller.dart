import 'package:get/get.dart';
import 'package:the_company/database/models/register_user.dart';

class InitController extends GetxController {
  var _isLoading = false.obs;

  Rx<UserData> _userData = UserData("", "", "").obs;
  // late Rx<WalletData> _walletData = WalletData(, income, balance).obs;

  Rx<UserData> get userData => _userData;

  // @override
  // void onInit() {
  //   super.onInit();
  //   var userData = UserData("", "", "");
  //   _userData(userData);
  // }

  get isLoading => _isLoading;

  void updateLoading(var isLoading) {
    _isLoading.value = isLoading;
  }

  void updateUserData(UserData data) {
    _userData(data);
  }
}
