import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/shop/domain/entities/category_entity/category_entity.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../helpers/helper_functions.dart';
import '../containers/rounded_container.dart';
import 'category_card.dart';

class CategoryShowCase extends StatelessWidget {
  const CategoryShowCase({
    super.key,
    required this.images,
    required this.category,
  });
  final List<String> images;
  final CategoryEntity category;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      showBorder: true,
      borderColor: AppColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.md.w, vertical: AppSizes.md.h),
      margin: EdgeInsets.only(bottom: AppSizes.spaceBtwItems.h),
      child: Column(
        children: [
          CategoryCard(
            showBorder: false,
            category: category,
          ),
          if (images.isNotEmpty) SizedBox(height: AppSizes.spaceBtwItems.h),
          if (images.isNotEmpty)
            Row(
                children: images
                    .map((e) => topProductInCategory(context, e))
                    .toList())
        ],
      ),
    );
  }

  Widget topProductInCategory(BuildContext context, String image) {
    return Expanded(
      child: RoundedContainer(
        height: 100.h,
        backgroundColor: HelperFunctions.isDarkMode(context)
            ? AppColors.darkerGrey
            : AppColors.light,
        margin: EdgeInsets.only(right: AppSizes.sm.w),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
