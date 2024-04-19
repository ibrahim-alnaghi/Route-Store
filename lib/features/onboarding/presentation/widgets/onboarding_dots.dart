import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/device/device_utility.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../bloc/onboarding_bloc.dart';

class OnboardingDots extends StatelessWidget {
  const OnboardingDots({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: DeviceUtils.getBottomNavigationBarHeight() + 25.h,
        left: AppSizes.defaultSpace.w,
        child: SmoothPageIndicator(
          controller: context.read<OnboardingBloc>().pageController,
          onDotClicked: (pageIndex) {
            context.read<OnboardingBloc>().add(DotNavigationClick(pageIndex));
          },
          count: 3,
          effect: ExpandingDotsEffect(
              activeDotColor: HelperFunctions.isDarkMode(context)
                  ? AppColors.light
                  : AppColors.dark,
              dotHeight: 6.h),
        ));
  }
}
