import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/keys_constants.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/routes/routes.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final PageController pageController = PageController();

  OnboardingBloc() : super(OnboardingInitial()) {
    on<DotNavigationClick>((event, emit) {
      pageController.animateToPage(
        event.pageIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
      );
    });

    on<NextPage>((event, emit) {
      if (pageController.page == 2) {
        _navigateToLogin(event.context);
      } else {
        pageController.nextPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.ease,
        );
      }
    });

    on<SkipOnboarding>((event, emit) {
      _navigateToLogin(event.context);
    });
  }

  void _navigateToLogin(BuildContext context) {
    CacheHelper.saveData(key: onBoardingKey, value: true).then((value) {
      if (value) {
        context.pushNamedAndRemoveUntil(
          Routes.login,
        );
      }
    });
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
