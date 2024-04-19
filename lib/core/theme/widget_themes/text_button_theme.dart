import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TextButtonThemeStyle {
  static final darkTextButtonStyle = TextButtonThemeData(
      style: TextButton.styleFrom(
    foregroundColor: AppColors.white,
  ));

  static final lightTextButtonStyle = TextButtonThemeData(
      style: TextButton.styleFrom(
    foregroundColor: AppColors.black,
  ));
}
