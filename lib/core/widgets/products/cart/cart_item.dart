import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_product_entity.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../helpers/helper_functions.dart';
import '../../brands/brand_title_with_verify_icon.dart';
import '../../images/rounded_image.dart';
import '../product_title_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.productDetails,
  });
  final CartProductEntity productDetails;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedImage(
          imageUrl: productDetails.coverImage,
          isNetWorkImage: true,
          width: 60.w,
          height: 60.h,
          fit: BoxFit.cover,
          backgroundColor: HelperFunctions.isDarkMode(context)
              ? AppColors.darkerGrey
              : AppColors.light,
        ),
        SizedBox(
          width: AppSizes.spaceBtwItems.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BrandTitleWithVerifyIcon(
                title: productDetails.productBrand.categoryName,
              ),
              Flexible(
                child: ProductTitleText(
                  title: productDetails.productName,
                  maxLines: 1,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
