import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/device/device_utility.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../bloc/onboarding_bloc.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: DeviceUtils.getBottomNavigationBarHeight().h,
        right: AppSizes.defaultSpace.w,
        child: ElevatedButton(
          onPressed: () {
            context.read<OnboardingBloc>().add(NextPage(context));
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: HelperFunctions.isDarkMode(context)
                  ? AppColors.primary
                  : AppColors.black),
          child: const Icon(Iconsax.arrow_right_3),
        ));
  }
}
