part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SaveTokenEvent extends LoginEvent {
  final String phone;
  final String otp;

  const SaveTokenEvent(this.phone, this.otp);

  @override
  List<Object> get props => [phone, otp];
}
