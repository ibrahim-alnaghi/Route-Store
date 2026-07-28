part of 'edit_profile_bloc.dart';

class EditProfileStates extends Equatable {
  final RequestStates status;
  final String? errorMessage;

  const EditProfileStates({
    required this.status,
    this.errorMessage,
  });

  EditProfileStates copyWith({
    RequestStates? status,
    String? errorMessage,
  }) {
    return EditProfileStates(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
