import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/sizes.dart';
import '../layouts/grid_view_layout.dart';
import 'shimmer.dart';

class ProductCardVerticalShimmer extends StatelessWidget {
  const ProductCardVerticalShimmer({
    super.key,
    this.itemCount = 4,
  });
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return GridViewLayout(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 180.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(width: 180.w, height: 180.h),
              SizedBox(
                height: AppSizes.spaceBtwItems.h,
              ),
              ShimmerEffect(width: 160.w, height: 15.h),
              SizedBox(
                height: AppSizes.spaceBtwItems / 2.h,
              ),
              ShimmerEffect(width: 110.w, height: 15.h),
            ],
          ),
        );
      },
    );
  }
}
