import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/shop/domain/entities/category_entity/category_entity.dart';
import '../../constants/enums.dart';
import '../../constants/sizes.dart';
import '../containers/rounded_container.dart';
import '../images/circular_image.dart';
import 'brand_title_text.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.category,
  });
  final bool showBorder;
  final CategoryEntity category;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.sm.h, vertical: AppSizes.sm.w),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(children: [
          CircularImage(
            image: category.categoryImage,
            isNetworkImage: true,
            fit: BoxFit.cover,
            padding: 0,
          ),
          SizedBox(
            width: AppSizes.spaceBtwItems / 2.w,
          ),
          BrandTitleText(
            title: category.categoryName,
            brandTextSize: TextSizes.large,
          )
        ]),
      ),
    );
  }
}
