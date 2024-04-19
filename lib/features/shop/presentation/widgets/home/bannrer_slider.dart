import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/containers/circular_container.dart';
import '../../../../../core/widgets/images/rounded_image.dart';
import '../../blocs/home/home_bloc.dart';

class BannrerSlider extends StatelessWidget {
  final List<String> bannrers;
  const BannrerSlider({
    super.key,
    required this.bannrers,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: (index, reason) {
                  context
                      .read<HomeBloc>()
                      .add(UpdateBannrerIndex(index: index));
                },
              ),
              items: bannrers
                  .map((e) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.defaultSpace / 2.w),
                        child: RoundedImage(
                          imageUrl: e,
                          fit: BoxFit.fill,
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwItems,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < bannrers.length; i++)
                  CircularContainer(
                      width: 20.w,
                      height: 4.h,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor: state.bannrerIndex == i
                          ? AppColors.primary
                          : AppColors.grey),
              ],
            )
          ],
        );
      },
    );
  }
}
