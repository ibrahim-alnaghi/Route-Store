import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../blocs/product_details/product_details_bloc.dart';
import '../../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../../core/widgets/images/rounded_image.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/device/device_utility.dart';
import '../../../../../core/helpers/extensions.dart';

class SliderShowFullImages extends StatelessWidget {
  final List<String> images;
  final String current;

  const SliderShowFullImages(
      {super.key, required this.images, required this.current});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                CupertinoIcons.clear,
              ))
        ],
      ),
      body: BlocProvider(
        create: (context) => ProductDetailsBloc()..add(ImageSelected(current)),
        child: BlocBuilder<ProductDetailsBloc, ProductDetailsStates>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.defaultSpace / 2.h,
                  horizontal: AppSizes.defaultSpace / 2.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: false,
                        viewportFraction: 1.0,
                        height: DeviceUtils.getScreenHeight(context) / 1.7,
                        onPageChanged: (index, data) {
                          context
                              .read<ProductDetailsBloc>()
                              .add(ImageSelected(images[index]));
                        },
                        initialPage: images.indexOf(current)),
                    items: images
                        .map((e) => ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppSizes.cardRadiusMd),
                              child: InteractiveViewer(
                                maxScale: 5,
                                child: CachedNetworkImage(
                                  imageUrl: _getSafeImageUrl(
                                      state.selectedImage ?? current),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(
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
                                .add(ImageSelected(images[index])),
                            border: Border.all(
                                width: 1,
                                color: state.selectedImage == images[index]
                                    ? AppColors.primary
                                    : Colors.transparent),
                            imageUrl: _getSafeImageUrl(images[index])),
                        separatorBuilder: (context, index) => SizedBox(
                              width: AppSizes.spaceBtwItems.w,
                            ),
                        itemCount: images.length),
                  ),
                  SizedBox(
                    height: AppSizes.appBarHeight.h,
                  )
                ],
              ),
            );
          },
        ),
      ),
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
