import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../helpers/helper_functions.dart';
import '../brands/brand_title_with_verify_icon.dart';
import '../containers/rounded_container.dart';
import '../images/rounded_image.dart';
import 'fav_icon.dart';
import 'product_price_text.dart';
import 'product_title_text.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310.w,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.productImageRadius.r),
          color: HelperFunctions.isDarkMode(context)
              ? AppColors.darkerGrey
              : AppColors.softGrey),
      child: Row(
        children: [
          RoundedContainer(
            height: 120.h,
            padding: EdgeInsets.symmetric(
                horizontal: AppSizes.sm.w, vertical: AppSizes.sm.h),
            backgroundColor: HelperFunctions.isDarkMode(context)
                ? AppColors.dark
                : AppColors.light,
            child: Stack(
              children: [
                SizedBox(
                  height: 120.h,
                  width: 120.w,
                  child: const RoundedImage(
                    imageUrl:
                        'https://res.cloudinary.com/dwp0imlbj/image/upload/v1680747186/Route-Academy-brands/1678286824747.png',
                    isNetWorkImage: true,
                    applyImageRadius: true,
                  ),
                ),
                Positioned(
                  top: 3.h,
                  left: 6.w,
                  child: RoundedContainer(
                    radius: AppSizes.sm,
                    backgroundColor: AppColors.secondary.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.sm.w, vertical: AppSizes.xs.h),
                    child: Text(
                      '23%',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: AppColors.black),
                    ),
                  ),
                ),
                Positioned(
                  top: 3.h,
                  right: 6.w,
                  child: const FavIcon(
                    productID: 'productEntity.productID',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 172.w,
            child: Padding(
              padding: EdgeInsets.only(top: AppSizes.sm.h, left: AppSizes.sm.w),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProductTitleText(
                        title:
                            'Victus 16-D1016Ne Laptop With 16-Inch Display Core I7-12700H Processor',
                        smallSize: true,
                      ),
                      SizedBox(
                        height: AppSizes.spaceBtwItems / 2.h,
                      ),
                      const BrandTitleWithVerifyIcon(title: 'Nike')
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(child: ProductPriceText(price: '1200')),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.dark,
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(AppSizes.cardRadiusMd.r),
                                bottomRight: Radius.circular(
                                    AppSizes.productImageRadius.r))),
                        child: SizedBox(
                          width: AppSizes.iconLg * 1.2.w,
                          height: AppSizes.iconLg * 1.2.h,
                          child: const Center(
                            child: Icon(
                              Iconsax.add,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
