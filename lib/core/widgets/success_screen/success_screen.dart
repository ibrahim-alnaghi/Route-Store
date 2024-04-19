import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../device/device_utility.dart';

class SuccessScreen extends StatelessWidget {
  final SuccessScreenModel screenModel;
  const SuccessScreen({super.key, required this.screenModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
                  top: AppSizes.appBarHeight.h,
                  bottom: AppSizes.defaultSpace.h,
                  right: AppSizes.defaultSpace.w,
                  left: AppSizes.defaultSpace.w) *
              2,
          child: Column(
            children: [
              Lottie.asset(
                screenModel.animation,
                width: DeviceUtils.getScreenWidth(context) * 06,
              ),
              SizedBox(
                height: AppSizes.spaceBtwSections.h,
              ),
              Text(
                screenModel.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: AppSizes.spaceBtwItems.h,
              ),
              Text(
                screenModel.subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: AppSizes.spaceBtwSections.h,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => screenModel.onTap(context),
                    child: const Text(AppTexts.cContinue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessScreenModel {
  final String animation, title, subTitle;
  final Function(BuildContext context) onTap;

  SuccessScreenModel(
      {required this.animation,
      required this.title,
      required this.subTitle,
      required this.onTap});
}
