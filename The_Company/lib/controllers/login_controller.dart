import 'package:get/get.dart';

class LoginController extends GetxController{

  var _isLoading = false.obs;

  get isLoading => _isLoading;

  void updateLoading(var isLoading) {
    _isLoading.value = isLoading;
  }

}