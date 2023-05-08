import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];

  get token => null;
}

class DataInitial extends DataState {}

class TokenSavedState extends DataState {}

class TokenLoadedState extends DataState {
  @override
  final String token;

  const TokenLoadedState(this.token);

  @override
  List<Object> get props => [token];
}

class TokenErrorState extends DataState {}

class MoviesLoadedState extends DataState {
  final Map<String, dynamic> moviesData;

  const MoviesLoadedState(this.moviesData);

  @override
  List<Object> get props => [moviesData];
}

class UserDataTicketsState extends DataState {
  final Map<String, dynamic> userTicketsData;

  const UserDataTicketsState(this.userTicketsData);

  @override
  List<Object> get props => [userTicketsData];
}

class GetUserTicketsErrorState extends DataState {}

class LoginState extends DataState {
  final Map<String, dynamic> loginData;

  const LoginState(this.loginData);

  @override
  List<Object> get props => [loginData];
}



