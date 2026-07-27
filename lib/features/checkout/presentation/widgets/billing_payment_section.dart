import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/widgets/containers/rounded_container.dart';
import '../../../../core/widgets/texts/section_heading.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeading(
          title: 'Payment Method',
          showActionButton: false,
        ),
        SizedBox(
          height: AppSizes.spaceBtwItems / 2.h,
        ),
        Row(
          children: [
            RoundedContainer(
              width: 60.w,
              height: 35.h,
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.sm.h, horizontal: AppSizes.sm.w),
              backgroundColor: HelperFunctions.isDarkMode(context)
                  ? AppColors.light
                  : AppColors.white,
              child: const Icon(Icons.money, color: AppColors.primary),
            ),
            SizedBox(
              width: AppSizes.spaceBtwItems / 2.w,
            ),
            Text(
              'Cash on Delivery',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        )
      ],
    );
  }
}
