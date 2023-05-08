part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationWithOtpRequested extends RegistrationEvent {
  final String phone;

  const RegistrationWithOtpRequested({required this.phone});

  @override
  List<Object> get props => [phone];
}