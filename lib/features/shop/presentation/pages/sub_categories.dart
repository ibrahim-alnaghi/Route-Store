import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/images/rounded_image.dart';
import '../../../../core/widgets/products/product_card_horizontal.dart';
import '../../../../core/widgets/texts/section_heading.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Electronics'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.defaultSpace.w,
              vertical: AppSizes.defaultSpace.h),
          child: Column(
            children: [
              const RoundedImage(
                imageUrl: AppImages.banner3,
                width: double.infinity,
                height: null,
                applyImageRadius: true,
              ),
              SizedBox(
                height: AppSizes.spaceBtwSections.h,
              ),
              Column(
                children: [
                  SectionHeading(
                    title: 'Laptops & Accessories',
                    showActionButton: true,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwItems / 2.h,
                  ),
                  SizedBox(
                    height: 120.h,
                    child: ListView.separated(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(
                              width: AppSizes.spaceBtwItems / 2.w,
                            ),
                        itemBuilder: (context, index) =>
                            const ProductCardHorizontal()),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
