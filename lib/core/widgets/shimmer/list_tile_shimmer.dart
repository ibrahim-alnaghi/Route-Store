import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/sizes.dart';
import 'shimmer.dart';

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerEffect(
          width: 50.w,
          height: 50.h,
          radius: 50.r,
        ),
        SizedBox(width: AppSizes.spaceBtwItems.w),
        ShimmerEffect(
          width: 100.w,
          height: 15.h,
        )
      ],
    );
  }
}
