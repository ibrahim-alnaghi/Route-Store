import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/brands/brand_title_with_verify_icon.dart';
import '../../../../../core/widgets/containers/rounded_container.dart';
import '../../../../../core/widgets/images/circular_image.dart';
import '../../../../../core/widgets/products/product_price_text.dart';
import '../../../../../core/widgets/products/product_title_text.dart';
import '../../../../shop/domain/entities/product_entity/product_entity.dart';

class ProductMetaData extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductMetaData({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (productEntity.productPriceAfterDiscount != 0)
              Row(
                children: [
                  RoundedContainer(
                    radius: AppSizes.sm,
                    backgroundColor: AppColors.secondary.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.sm.w, vertical: AppSizes.xs.h),
                    child: Text(
                      '${productEntity.discountPercentage}%',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: AppColors.black),
                    ),
                  ),
                  SizedBox(
                    width: AppSizes.spaceBtwItems.w,
                  ),
                  Text(
                    'EGP ${productEntity.productPrice}',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .apply(decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(
                    width: AppSizes.spaceBtwItems.w,
                  ),
                ],
              ),
            ProductPriceText(
              price: productEntity.productPriceAfterDiscount != 0
                  ? productEntity.productPriceAfterDiscount.toString()
                  : productEntity.productPrice.toString(),
              isLarge: true,
            ),
          ],
        ),
        SizedBox(
          height: AppSizes.spaceBtwItems / 1.5.h,
        ),
        ProductTitleText(title: productEntity.productName),
        SizedBox(
          height: AppSizes.spaceBtwItems / 1.5.h,
        ),
        Row(
          children: [
            const ProductTitleText(title: 'Status'),
            SizedBox(
              width: AppSizes.spaceBtwItems.w,
            ),
            Text(
              productEntity.productQuantity != 0 ? 'In Stock' : 'Out of Stock',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(
          height: AppSizes.spaceBtwItems / 1.5.h,
        ),
        Row(
          children: [
            CircularImage(
                width: 32.w,
                height: 32.h,
                isNetworkImage: true,
                padding: 0,
                fit: BoxFit.fill,
                image: productEntity.brandImage),
            SizedBox(
              width: AppSizes.spaceBtwItems / 2.w,
            ),
            BrandTitleWithVerifyIcon(
              title: productEntity.productBrand,
              brandTextSize: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
