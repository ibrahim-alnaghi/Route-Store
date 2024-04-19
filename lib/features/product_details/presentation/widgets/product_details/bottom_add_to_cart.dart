import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/widgets/icons/circular_icon.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.defaultSpace.w,
        vertical: AppSizes.defaultSpace / 2.h,
      ),
      decoration: BoxDecoration(
          color: HelperFunctions.isDarkMode(context)
              ? AppColors.darkerGrey
              : AppColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSizes.cardRadiusLg),
            topRight: Radius.circular(AppSizes.cardRadiusLg),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            CircularIcon(
              icon: Iconsax.minus,
              backgroundColor: AppColors.darkGrey,
              width: 40.w,
              height: 40.h,
              color: AppColors.white,
            ),
            SizedBox(
              width: AppSizes.spaceBtwItems.w,
            ),
            Text(
              '2',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              width: AppSizes.spaceBtwItems.w,
            ),
            CircularIcon(
              icon: Iconsax.add,
              backgroundColor: AppColors.black,
              width: 40.w,
              height: 40.h,
              color: AppColors.white,
            ),
          ],
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.md.h, horizontal: AppSizes.md.w)),
            onPressed: () {},
            child: const Text('Add To Cart'))
      ]),
    );
  }
}
