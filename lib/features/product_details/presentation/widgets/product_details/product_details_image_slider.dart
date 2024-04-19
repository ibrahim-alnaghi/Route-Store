import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../../core/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import '../../../../../core/widgets/images/rounded_image.dart';
import '../../../../../core/widgets/products/fav_icon.dart';
import '../../../../shop/domain/entities/product_entity/product_entity.dart';
import '../../blocs/product_details/product_details_bloc.dart';
import 'slider_show_full_images.dart';

class ProductDetailsImageSlider extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailsImageSlider({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
      builder: (context, state) {
        return CurvedEdgeWidget(
          child: Container(
            color: HelperFunctions.isDarkMode(context)
                ? AppColors.darkerGrey
                : AppColors.light,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: animation.value,
                              child: SliderShowFullImages(
                                images: productEntity.productImages,
                                current: state.selectedImage!,
                              ),
                            );
                          },
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                      reverseTransitionDuration:
                          const Duration(milliseconds: 200),
                    ));
                  },
                  child: SizedBox(
                      height: 400.h,
                      child: Center(
                          child: CachedNetworkImage(
                        imageUrl: _getSafeImageUrl(state.selectedImage ??
                            productEntity.productImages.first),
                        width: double.infinity,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                            color: AppColors.primary,
                          ),
                        ),
                      ))),
                ),
                Positioned(
                  right: 0.w,
                  bottom: 30.h,
                  left: AppSizes.defaultSpace.w,
                  child: SizedBox(
                    height: 80.h,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) => RoundedImage(
                            width: 80.w,
                            isNetWorkImage: true,
                            fit: BoxFit.cover,
                            onPressd: () => context
                                .read<ProductDetailsBloc>()
                                .add(ImageSelected(
                                    productEntity.productImages[index])),
                            border: Border.all(
                                color: state.selectedImage ==
                                        productEntity.productImages[index]
                                    ? AppColors.primary
                                    : Colors.transparent),
                            imageUrl: _getSafeImageUrl(
                                productEntity.productImages[index])),
                        separatorBuilder: (context, index) => SizedBox(
                              width: AppSizes.spaceBtwItems.w,
                            ),
                        itemCount: productEntity.productImages.length),
                  ),
                ),
                CustomAppBar(
                  showBackArrow: true,
                  actions: [
                    FavIcon(
                      productID: productEntity.productID,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String _getSafeImageUrl(String imageUrl) {
    if (imageUrl.startsWith("https")) {
      return imageUrl;
    } else {
      return "https://res.cloudinary.com/dwp0imlbj/image/upload/Route-Academy-products/$imageUrl";
    }
  }
}
