import 'package:flutter/material.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
      fontFamily: 'Lato',
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: CustomTextTheme.lightTextTheme,
      elevatedButtonTheme: CustomElevatedTheme.lightElevatedButtonTheme,
      appBarTheme: CustomAppbarTheme.lightAppBarTheme,
      bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
      checkboxTheme: CustomCheckBoxTheme.lightCheckboxTheme,
      chipTheme: CustomChipTheme.lightChipThemeData,
      outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: CustomTextFieldTheme.lightInputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      colorScheme: const ColorScheme.dark(),
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme: CustomTextTheme.darkTextTheme,
      elevatedButtonTheme: CustomElevatedTheme.darkElevatedButtonTheme,
      appBarTheme: CustomAppbarTheme.darkAppBarTheme,
      bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
      checkboxTheme: CustomCheckBoxTheme.darkCheckboxTheme,
      chipTheme: CustomChipTheme.darkChipThemeData,
      outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: CustomTextFieldTheme.darkInputDecorationTheme);
}
