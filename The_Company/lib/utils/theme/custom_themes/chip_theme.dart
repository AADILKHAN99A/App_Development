import 'package:flutter/material.dart';
import 'package:the_company/utils/constants/color.dart';

class CustomChipTheme {
  CustomChipTheme._();

  static ChipThemeData lightChipThemeData = ChipThemeData(
      disabledColor: Colors.grey.withOpacity(0.4),
      labelStyle: const TextStyle(color: Colors.black),
      selectedColor: CColors.primary,
      padding: const EdgeInsets.all(12.0),
      checkmarkColor: Colors.white);

  static ChipThemeData darkChipThemeData = const ChipThemeData(
      disabledColor: Colors.grey,
      labelStyle: TextStyle(color: Colors.white),
      selectedColor: CColors.primary,
      padding: EdgeInsets.all(12.0),
      checkmarkColor: Colors.white);
}
