import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../containers/rounded_container.dart';
import 'boxes_shimmer.dart';
import 'list_tile_shimmer.dart';

class CategoryTopProductsShimmer extends StatelessWidget {
  const CategoryTopProductsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      showBorder: true,
      borderColor: AppColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.md.h, vertical: AppSizes.md.w),
      margin: EdgeInsets.only(bottom: AppSizes.spaceBtwItems.h),
      child: Column(
        children: [
          const ListTileShimmer(),
          SizedBox(height: AppSizes.spaceBtwItems.h),
          const BoxesShimmer(),
          SizedBox(height: AppSizes.spaceBtwItems.h),
        ],
      ),
    );
  }
}
