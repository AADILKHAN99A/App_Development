import 'package:flutter/material.dart';

import '../../constants/color.dart';

class CustomTextFieldTheme {
  CustomTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    prefixStyle: TextStyle(color: Colors.grey),
    labelStyle: TextStyle(
        fontSize: 15, color: CColors.accent, fontWeight: FontWeight.w600),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.blue, width: 2)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.blue, width: 2)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.grey, width: 2)),
  );

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    prefixStyle: TextStyle(color: Colors.grey),
    labelStyle: TextStyle(
        fontSize: 15, color: CColors.accent, fontWeight: FontWeight.w600),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.blue, width: 2)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.blue, width: 2)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.grey, width: 2)),
  );
}
