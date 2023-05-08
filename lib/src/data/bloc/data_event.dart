import 'package:equatable/equatable.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends DataEvent {}

class GetMoviesByIdEvent extends DataEvent {
  final String userId;

  const GetMoviesByIdEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class GetUserTicketsEvent extends DataEvent {}

class GetUserTicketsErrorEvent extends DataEvent {}

class GetLoginEvent extends DataEvent {
  final String otp;
  final String phone;

  const GetLoginEvent(this.otp, this.phone);

  @override
  List<Object> get props => [otp, phone];
}
