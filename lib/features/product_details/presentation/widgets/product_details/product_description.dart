import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/texts/section_heading.dart';
import '../../../../shop/domain/entities/product_entity/product_entity.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.productEntity,
  });

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(title: 'Description'),
        SizedBox(
          height: AppSizes.spaceBtwItems.h,
        ),
        ReadMoreText(
          productEntity.productDescription,
          trimLength: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Show More',
          trimExpandedText: ' Less',
          moreStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
          lessStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
