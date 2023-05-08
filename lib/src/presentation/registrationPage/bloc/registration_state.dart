part of 'registration_bloc.dart';

@immutable
abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailure extends RegistrationState {
  final String errorMessage;

  const RegistrationFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}