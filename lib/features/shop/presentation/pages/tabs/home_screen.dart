import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/image_strings.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/containers/primary_header_container.dart';
import '../../../../../core/widgets/containers/search_container.dart';
import '../../../../../core/widgets/texts/section_heading.dart';
import '../../widgets/home/bannrer_slider.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/home_brands.dart';
import '../../widgets/home/popular_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PrimaryHeaderContainer(
            child: Column(
              children: [
                const HomeAppBar(),
                SizedBox(
                  height: AppSizes.spaceBtwItems.h,
                ),
                const SearchContainer(
                  text: 'Search in Store',
                ),
                SizedBox(
                  height: AppSizes.spaceBtwSections.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppSizes.defaultSpace),
                  child: Column(
                    children: [
                      const SectionHeading(
                        title: 'Popular Brands',
                        textColor: AppColors.white,
                      ),
                      SizedBox(
                        height: AppSizes.spaceBtwItems.h,
                      ),
                      const HomeBrands()
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSizes.spaceBtwSections.h,
                )
              ],
            ),
          ),
          Column(
            children: [
              const BannrerSlider(
                bannrers: [
                  AppImages.banner4,
                  AppImages.banner5,
                  AppImages.banner6,
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.defaultSpace.h,
                    horizontal: AppSizes.defaultSpace.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSizes.spaceBtwSections.h,
                    ),
                    SectionHeading(
                      title: 'Popular Products',
                      showActionButton: true,
                      onPressed: () =>
                          context.pushNamed(Routes.allProducts, arguments: {
                        'queryParameters': {'sort': '-price'},
                        'title': 'Popular Products'
                      }),
                    ),
                    SizedBox(
                      height: AppSizes.spaceBtwItems.h,
                    ),
                    const PopularProducts(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
