import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/texts/section_heading.dart';
import '../../../product_details/presentation/widgets/product_details/bottom_add_to_cart.dart';
import '../../../product_details/presentation/widgets/product_details/product_description.dart';
import '../../../product_details/presentation/widgets/product_details/product_details_image_slider.dart';
import '../../../product_details/presentation/widgets/product_details/product_meta_data.dart';
import '../../../product_details/presentation/widgets/product_details/rating_and_share.dart';
import '../../../shop/domain/entities/product_entity/product_entity.dart';

class ProductDetails extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetails({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductDetailsImageSlider(
              productEntity: productEntity,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: AppSizes.defaultSpace.w,
                  left: AppSizes.defaultSpace.w,
                  bottom: AppSizes.defaultSpace.h),
              child: Column(
                children: [
                  RatingAndShare(
                    productEntity: productEntity,
                  ),
                  ProductMetaData(
                    productEntity: productEntity,
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwSections.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Checkout'),
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwSections.h,
                  ),
                  ProductDescription(productEntity: productEntity),
                  const Divider(),
                  SizedBox(
                    height: AppSizes.spaceBtwItems.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionHeading(
                        title: 'Reviews (199)',
                      ),
                      IconButton(
                          onPressed: () =>
                              context.pushNamed(Routes.productReviews),
                          icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwSections.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
