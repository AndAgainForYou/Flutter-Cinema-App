part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class TokenSavedState extends LoginState {}

class TokenErrorState extends LoginState {}
