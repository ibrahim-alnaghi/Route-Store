import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:route_store/core/widgets/products/product_card_add_to_cart_button.dart';
import 'fav_icon.dart';

import '../../../features/shop/domain/entities/product_entity/product_entity.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../helpers/extensions.dart';
import '../../helpers/helper_functions.dart';
import '../../routes/routes.dart';
import '../brands/brand_title_with_verify_icon.dart';
import '../containers/rounded_container.dart';
import '../images/rounded_image.dart';
import '../shadows/shadows.dart';
import 'product_price_text.dart';
import 'product_title_text.dart';

class ProductCardVertical extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductCardVertical({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.pushNamed(Routes.productDetails, arguments: productEntity),
      child: Container(
        width: 180.w,
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
        decoration: BoxDecoration(
            boxShadow: [ShadowsStyle.verticalProduct],
            borderRadius: BorderRadius.circular(AppSizes.productImageRadius.r),
            color: HelperFunctions.isDarkMode(context)
                ? AppColors.darkerGrey
                : AppColors.white),
        child: Column(
          children: [
            RoundedContainer(
              height: 140.h,
              backgroundColor: HelperFunctions.isDarkMode(context)
                  ? AppColors.darkerGrey
                  : AppColors.light,
              child: Stack(
                children: [
                  RoundedImage(
                    imageUrl: productEntity.productImageCover,
                    width: double.infinity,
                    isNetWorkImage: true,
                    fit: BoxFit.cover,
                  ),
                  if (productEntity.productPriceAfterDiscount != 0)
                    Positioned(
                      top: 3.h,
                      left: 6.w,
                      child: RoundedContainer(
                        radius: AppSizes.sm,
                        backgroundColor: AppColors.secondary.withOpacity(0.8),
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.sm.w, vertical: AppSizes.xs.h),
                        child: Text(
                          '${productEntity.discountPercentage.toString()}%',
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
                    child: FavIcon(
                      productID: productEntity.productID,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSizes.spaceBtwItems / 2.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: AppSizes.sm.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductTitleText(
                      title: productEntity.productName,
                      smallSize: true,
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwItems / 2.h,
                    ),
                    BrandTitleWithVerifyIcon(
                      title: productEntity.productBrand,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProductPriceText(
                          price: productEntity.productPriceAfterDiscount == 0
                              ? productEntity.productPrice.toString()
                              : productEntity.productPriceAfterDiscount
                                  .toString(),
                        ),
                        ProductCardAddToCartButton(
                          productID: productEntity.productID,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
