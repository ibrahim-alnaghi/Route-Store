part of 'personalization_bloc.dart';

abstract class PersonalizationEvent extends Equatable {
  const PersonalizationEvent();

  @override
  List<Object?> get props => [];
}

class ChangeThemeMode extends PersonalizationEvent {}
