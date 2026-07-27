import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../../../personalization/domain/entities/adress_entity.dart';

class BillingAdressSection extends StatelessWidget {
  const BillingAdressSection(
      {super.key, required this.selectedAddress, required this.onChangePressed});

  final AdressEntity? selectedAddress;
  final VoidCallback onChangePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Shiping Adress',
          buttonTitle: 'Change',
          showActionButton: true,
          onPressed: onChangePressed,
        ),
        SizedBox(
          height: AppSizes.spaceBtwItems / 2.h,
        ),
        if (selectedAddress == null)
          Text(
            'No address selected — tap Change to add one',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        else ...[
          Text(
            selectedAddress!.adressName,
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
              Text(selectedAddress!.adressPhone),
            ],
          ),
          SizedBox(
            height: AppSizes.sm / 2.h,
          ),
          Row(
            children: [
              const Icon(Icons.location_history,
                  color: AppColors.grey, size: 16),
              SizedBox(
                width: AppSizes.spaceBtwItems.w,
              ),
              Expanded(
                child: Text(
                  selectedAddress!.adressDetails,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
