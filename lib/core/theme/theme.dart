import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'widget_themes/appbar_theme.dart';
import 'widget_themes/bottom_sheet_theme.dart';
import 'widget_themes/checkbox_theme.dart';
import 'widget_themes/chip_theme.dart';
import 'widget_themes/elevated_button_theme.dart';
import 'widget_themes/outlined_button_theme.dart';
import 'widget_themes/text_button_theme.dart';
import 'widget_themes/text_field_theme.dart';
import 'widget_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: TextThemeStyle.lightTextTheme,
    chipTheme: ChipThemeStyle.lightChipTheme,
    scaffoldBackgroundColor: AppColors.light,
    appBarTheme: AppBarThemeStyle.lightAppBarTheme,
    checkboxTheme: CheckboxThemeStyle.lightCheckboxTheme,
    bottomSheetTheme: BottomSheetThemeStyle.lightBottomSheetTheme,
    elevatedButtonTheme: ElevatedButtonThemeStyle.lightElevatedButtonTheme,
    outlinedButtonTheme: OutlinedButtonThemeStyle.lightOutlinedButtonTheme,
    textButtonTheme: TextButtonThemeStyle.lightTextButtonStyle,
    inputDecorationTheme: TextFormFieldThemeStyle.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    textTheme: TextThemeStyle.darkTextTheme,
    chipTheme: ChipThemeStyle.darkChipTheme,
    scaffoldBackgroundColor: AppColors.dark,
    appBarTheme: AppBarThemeStyle.darkAppBarTheme,
    checkboxTheme: CheckboxThemeStyle.darkCheckboxTheme,
    bottomSheetTheme: BottomSheetThemeStyle.darkBottomSheetTheme,
    elevatedButtonTheme: ElevatedButtonThemeStyle.darkElevatedButtonTheme,
    outlinedButtonTheme: OutlinedButtonThemeStyle.darkOutlinedButtonTheme,
    textButtonTheme: TextButtonThemeStyle.darkTextButtonStyle,
    inputDecorationTheme: TextFormFieldThemeStyle.darkInputDecorationTheme,
  );
}
