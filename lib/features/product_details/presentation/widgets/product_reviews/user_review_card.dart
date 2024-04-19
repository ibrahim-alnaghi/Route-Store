import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/image_strings.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/widgets/containers/rounded_container.dart';
import '../../../../../core/widgets/products/rating_indicator_bar.dart';

class UserReviewCard extends StatelessWidget {
  final String name, image, comment;
  const UserReviewCard(
      {super.key,
      required this.name,
      required this.image,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(image),
                ),
                SizedBox(
                  width: AppSizes.spaceBtwItems.w,
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        SizedBox(
          height: AppSizes.spaceBtwItems.h,
        ),
        Row(
          children: [
            const RatingIndicatorBar(rating: 5),
            SizedBox(
              width: AppSizes.spaceBtwItems.w,
            ),
            Text(
              '14 Feb, 2024',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        SizedBox(
          height: AppSizes.spaceBtwItems.h,
        ),
        ReadMoreText(
          comment,
          trimLength: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Show More',
          trimExpandedText: ' Less',
          moreStyle: TextStyle(fontSize: 14.sp, color: AppColors.primary),
          lessStyle: TextStyle(fontSize: 14.sp, color: AppColors.primary),
        ),
        SizedBox(
          height: AppSizes.spaceBtwItems.h,
        ),
        RoundedContainer(
          backgroundColor: HelperFunctions.isDarkMode(context)
              ? AppColors.darkerGrey
              : AppColors.grey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSizes.md.w, vertical: AppSizes.md.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(AppImages.appLogo),
                        ),
                        SizedBox(
                          width: AppSizes.spaceBtwItems.w,
                        ),
                        Text(
                          'Route Store',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Text(
                      '14 Feb, 2024',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSizes.spaceBtwItems.h,
                ),
                ReadMoreText(
                  "Thank you so much for your glowing review! We're thrilled to hear that you had such a positive experience with us. Our team works hard to ensure that every aspect of our service exceeds expectations. We appreciate your recommendation and look forward to serving you again in the future!",
                  trimLength: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show More',
                  trimExpandedText: ' Less',
                  moreStyle:
                      TextStyle(fontSize: 14.sp, color: AppColors.primary),
                  lessStyle:
                      TextStyle(fontSize: 14.sp, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: AppSizes.spaceBtwItems.h,
        ),
      ],
    );
  }
}
