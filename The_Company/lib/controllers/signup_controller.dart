import 'package:get/get.dart';

class SignUpController extends GetxController {
  var _isLoading = false.obs;
  var _isOtpLoading = false.obs;

  get isLoading => _isLoading;

  get isOtpLoading => _isOtpLoading;

  void updateLoading(var isLoading) {
    _isLoading.value = isLoading;
  }

  void updateOtpLoading(var isOtpLoading) {
    _isOtpLoading.value = isOtpLoading;
  }
}
