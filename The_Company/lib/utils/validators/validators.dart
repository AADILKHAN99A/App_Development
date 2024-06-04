import 'package:get/get.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email is required";
    } else if (!GetUtils.isEmail(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // min password length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    // check for numbers

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // check for special characters

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?:{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String? confirmValue) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // password does not match
    if (value != confirmValue) {
      return "Password not same";
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    } else if (!GetUtils.isPhoneNumber(value)) {
      return 'Invalid phone number.';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First Name is required.';
    }
    return null;
  }

  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required.';
    } else if (!GetUtils.isUsername(value)) {
      return 'Invalid username';
    }
    return null;
  }
}
