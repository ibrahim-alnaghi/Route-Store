import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/device/device_utility.dart';
import '../bloc/onboarding_bloc.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: DeviceUtils.getAppBarHeight().h,
        right: AppSizes.defaultSpace.w,
        child: TextButton(
            onPressed: () {
              context.read<OnboardingBloc>().add(SkipOnboarding(context));
            },
            child: const Text(
              'Skip',
            )));
  }
}
