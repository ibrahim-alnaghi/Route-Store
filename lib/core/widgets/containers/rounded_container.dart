import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class RoundedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Clip? clipBehavior;
  const RoundedContainer(
      {super.key,
      this.child,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.showBorder = false,
      this.radius = AppSizes.cardRadiusLg,
      this.backgroundColor = AppColors.white,
      this.borderColor = AppColors.borderPrimary,
      this.clipBehavior});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w,
      height: height?.h,
      margin: margin,
      padding: padding,
      clipBehavior: clipBehavior ?? Clip.none,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius.r),
          border: showBorder ? Border.all(color: borderColor) : null),
      child: child,
    );
  }
}
