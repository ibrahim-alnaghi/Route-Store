import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_products_entity.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../helpers/helper_functions.dart';
import '../../icons/circular_icon.dart';

class ProductQuantityWithAddAndRemoveButtons extends StatelessWidget {
  const ProductQuantityWithAddAndRemoveButtons({
    super.key,
    required this.cartProductsEntity,
  });
  final CartProductsEntity cartProductsEntity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularIcon(
          icon: Iconsax.minus,
          width: 32.w,
          height: 32.h,
          size: AppSizes.md.w,
          color: HelperFunctions.isDarkMode(context)
              ? AppColors.white
              : AppColors.black,
          backgroundColor: HelperFunctions.isDarkMode(context)
              ? AppColors.darkGrey
              : AppColors.light,
        ),
        SizedBox(
          width: AppSizes.spaceBtwItems.w,
        ),
        Text(
          cartProductsEntity.itemCount.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          width: AppSizes.spaceBtwItems.w,
        ),
        CircularIcon(
          icon: Iconsax.add,
          width: 32.w,
          height: 32.h,
          size: AppSizes.md.w,
          color: AppColors.white,
          backgroundColor: AppColors.primary,
        ),
      ],
    );
  }
}
