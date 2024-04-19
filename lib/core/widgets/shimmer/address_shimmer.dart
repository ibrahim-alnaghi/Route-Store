import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../helpers/helper_functions.dart';
import '../containers/rounded_container.dart';
import 'shimmer.dart';

class AddressShimmer extends StatelessWidget {
  const AddressShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: double.infinity,
      showBorder: true,
      backgroundColor: Colors.transparent,
      borderColor: HelperFunctions.isDarkMode(context)
          ? AppColors.darkerGrey
          : AppColors.grey,
      margin: EdgeInsets.only(bottom: AppSizes.spaceBtwItems.h),
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.md.w, vertical: AppSizes.md.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerEffect(
            width: 100.w,
            height: 12.h,
          ),
          SizedBox(
            height: AppSizes.sm / 2.h,
          ),
          ShimmerEffect(
            width: 150.w,
            height: 12.h,
          ),
          SizedBox(
            height: AppSizes.sm / 2.h,
          ),
          ShimmerEffect(
            width: 200.w,
            height: 12.h,
          ),
        ],
      ),
    );
  }
}
