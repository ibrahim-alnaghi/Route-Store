import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../../helpers/helper_functions.dart';

class ShimmerEffect extends StatelessWidget {
  final double width, height, radius;
  final Color? color;
  const ShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.radius = 15,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: HelperFunctions.isDarkMode(context)
          ? Colors.grey[850]!
          : Colors.grey[300]!,
      highlightColor: HelperFunctions.isDarkMode(context)
          ? Colors.grey[700]!
          : Colors.grey[100]!,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
            color: color ??
                (HelperFunctions.isDarkMode(context)
                    ? AppColors.darkerGrey
                    : AppColors.white),
            borderRadius: BorderRadius.circular(radius.r)),
      ),
    );
  }
}
