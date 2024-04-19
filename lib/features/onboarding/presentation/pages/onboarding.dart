import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/image_strings.dart';
import '../../../../core/constants/text_strings.dart';
import '../bloc/onboarding_bloc.dart';
import '../widgets/onboarding_dots.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/onboarding_skip.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return Stack(
            children: [
              PageView(
                controller: context.read<OnboardingBloc>().pageController,
                children: const [
                  OnboardingPage(
                    image: AppImages.onBoardingImage1,
                    title: AppTexts.onBoardingTitle1,
                    subTitle: AppTexts.onBoardingSubTitle1,
                  ),
                  OnboardingPage(
                    image: AppImages.onBoardingImage2,
                    title: AppTexts.onBoardingTitle2,
                    subTitle: AppTexts.onBoardingSubTitle2,
                  ),
                  OnboardingPage(
                    image: AppImages.onBoardingImage3,
                    title: AppTexts.onBoardingTitle3,
                    subTitle: AppTexts.onBoardingSubTitle3,
                  ),
                ],
              ),
              const OnboardingSkip(),
              const OnboardingDots(),
              const OnboardingNextButton()
            ],
          );
        },
      ),
    );
  }
}
