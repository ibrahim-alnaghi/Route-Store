part of 'personalization_bloc.dart';

class PersonalizationStates extends Equatable {
  final bool isDark;
  const PersonalizationStates({required this.isDark});

  PersonalizationStates copyWith({
    bool? isDark,
  }) {
    return PersonalizationStates(isDark: isDark ?? this.isDark);
  }

  @override
  List<Object> get props => [isDark];
}
