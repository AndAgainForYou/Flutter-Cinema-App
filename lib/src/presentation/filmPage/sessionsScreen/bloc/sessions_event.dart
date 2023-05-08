part of 'sessions_bloc.dart';

abstract class SessionsEvent extends Equatable {
  const SessionsEvent();

  @override
  List<Object> get props => [];
}

class GetSessionsEvent extends SessionsEvent {
  final int movieId;

  const GetSessionsEvent(this.movieId);
}