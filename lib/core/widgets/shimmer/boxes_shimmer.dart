import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/sizes.dart';
import 'shimmer.dart';

class BoxesShimmer extends StatelessWidget {
  const BoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: ShimmerEffect(width: 150.w, height: 110.h)),
            SizedBox(width: AppSizes.spaceBtwItems.w),
            Expanded(child: ShimmerEffect(width: 150.w, height: 110.h)),
            SizedBox(width: AppSizes.spaceBtwItems.w),
            Expanded(child: ShimmerEffect(width: 150.w, height: 110.h)),
          ],
        )
      ],
    );
  }
}
