part of 'sessions_bloc.dart';

abstract class SessionsState extends Equatable {
  const SessionsState();
  
  @override
  List<Object> get props => [];
}

class SessionsInitial extends SessionsState {}

class SessionsDataState extends SessionsState {
  final Map<String, dynamic> sessions;

  const SessionsDataState(this.sessions);

  @override
  List<Object> get props => [sessions];
}

class SessionsDataErrorState extends SessionsState {}
