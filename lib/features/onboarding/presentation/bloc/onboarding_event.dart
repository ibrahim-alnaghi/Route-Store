part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class DotNavigationClick extends OnboardingEvent {
  final int pageIndex;

  const DotNavigationClick(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}

class NextPage extends OnboardingEvent {
  final BuildContext context;

  const NextPage(this.context);
  @override
  List<Object> get props => [context];
}

class SkipOnboarding extends OnboardingEvent {
  final BuildContext context;

  const SkipOnboarding(this.context);
  @override
  List<Object> get props => [context];
}
