import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../images/circular_image.dart';

class VerticalImageText extends StatelessWidget {
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function() onTap;
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = AppColors.white,
    this.backgroundColor,
    this.isNetworkImage = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: AppSizes.spaceBtwItems.w),
        child: Column(
          children: [
            CircularImage(
              image: image,
              fit: BoxFit.fill,
              padding: 0,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
            ),
            //
          ],
        ),
      ),
    );
  }
}
