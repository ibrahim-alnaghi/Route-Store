import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/sizes.dart';
import 'shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: AppSizes.spaceBtwItems.w,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              ShimmerEffect(
                width: 50.w,
                height: 50.h,
                radius: 50.r,
              ),
              //
            ],
          );
        },
      ),
    );
  }
}
