import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class OutlinedButtonThemeStyle {
  OutlinedButtonThemeStyle._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.dark,
      side: const BorderSide(color: AppColors.borderPrimary),
      textStyle: TextStyle(
          fontSize: 16.sp, color: AppColors.black, fontWeight: FontWeight.w600),
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.buttonHeight.h, horizontal: 20.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius.r)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.light,
      side: const BorderSide(color: AppColors.borderPrimary),
      textStyle: TextStyle(
          fontSize: 16.sp,
          color: AppColors.textWhite,
          fontWeight: FontWeight.w600),
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.buttonHeight.h, horizontal: 20.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius.r)),
    ),
  );
}
