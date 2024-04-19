import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/widgets/texts/section_heading.dart';

class BillingAdressSection extends StatelessWidget {
  const BillingAdressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Shiping Adress',
          buttonTitle: 'Change',
          showActionButton: true,
          onPressed: () {},
        ),
        SizedBox(
          height: AppSizes.spaceBtwItems / 2.h,
        ),
        Text(
          'Home',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: AppSizes.sm / 2.h,
        ),
        Row(
          children: [
            const Icon(Icons.phone, color: AppColors.grey, size: 16),
            SizedBox(
              width: AppSizes.spaceBtwItems.w,
            ),
            const Text('01024247323'),
          ],
        ),
        SizedBox(
          height: AppSizes.sm / 2.h,
        ),
        Row(
          children: [
            const Icon(Icons.location_history, color: AppColors.grey, size: 16),
            SizedBox(
              width: AppSizes.spaceBtwItems.w,
            ),
            const Expanded(
              child: Text(
                '123 Nile Street, Zamalek, 12345, Cairo, Egypt',
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
