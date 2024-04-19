import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../device/device_utility.dart';
import '../../helpers/helper_functions.dart';

class SearchContainer extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool showBorder, showBackground;
  final EdgeInsetsGeometry padding;
  final void Function()? onTap;
  const SearchContainer(
      {super.key,
      required this.text,
      this.icon = Iconsax.search_normal,
      this.showBorder = true,
      this.showBackground = true,
      this.onTap,
      this.padding =
          const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace)});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: DeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(AppSizes.md),
          decoration: BoxDecoration(
              color: showBackground
                  ? HelperFunctions.isDarkMode(context)
                      ? AppColors.dark
                      : AppColors.light
                  : Colors.transparent,
              borderRadius: showBorder
                  ? BorderRadius.circular(AppSizes.cardRadiusLg.r)
                  : null,
              border: Border.all(color: AppColors.grey)),
          child: Row(
            children: [
              Icon(
                icon,
                color: HelperFunctions.isDarkMode(context)
                    ? AppColors.light
                    : AppColors.dark,
              ),
              SizedBox(
                width: AppSizes.spaceBtwItems.w,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: HelperFunctions.isDarkMode(context)
                        ? AppColors.light
                        : AppColors.dark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
