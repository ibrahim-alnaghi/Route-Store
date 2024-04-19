import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class ChipThemeStyle {
  ChipThemeStyle._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: AppColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: AppColors.black),
    selectedColor: AppColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
    checkmarkColor: AppColors.white,
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: AppColors.darkerGrey,
    labelStyle: const TextStyle(color: AppColors.white),
    selectedColor: AppColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
    checkmarkColor: AppColors.white,
  );
}
