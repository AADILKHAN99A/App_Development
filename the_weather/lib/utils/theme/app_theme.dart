import 'package:flutter/material.dart';
import 'package:the_weather/utils/theme/custom_themes/appbar_theme.dart';
import 'package:the_weather/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:the_weather/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:the_weather/utils/theme/custom_themes/chip_theme.dart';
import 'package:the_weather/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:the_weather/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:the_weather/utils/theme/custom_themes/text_field_theme.dart';
import 'package:the_weather/utils/theme/custom_themes/text_theme.dart';

class AppTheme {
  static ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
    appBarTheme: CustomAppbarTheme.lightAppBarTheme,
    chipTheme: CustomChipTheme.lightChipThemeData,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: CustomCheckBoxTheme.lightCheckboxTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    textTheme: CustomTextTheme.lightTextTheme,
    inputDecorationTheme: CustomTextFieldTheme.lightInputDecorationTheme,
    elevatedButtonTheme: CustomElevatedTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark, seedColor: Colors.purple),
    appBarTheme: CustomAppbarTheme.darkAppBarTheme,
    chipTheme: CustomChipTheme.darkChipThemeData,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: CustomCheckBoxTheme.darkCheckboxTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    textTheme: CustomTextTheme.darkTextTheme,
    inputDecorationTheme: CustomTextFieldTheme.darkInputDecorationTheme,
    elevatedButtonTheme: CustomElevatedTheme.darkElevatedButtonTheme,
  );
}
