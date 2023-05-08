part of 'room_bloc.dart';

abstract class RoomState extends Equatable {
  const RoomState();
  
  @override
  List<Object> get props => [];
}

class RoomInitial extends RoomState {}

class CurrentSessionDataState extends RoomState {
  final Map<String, dynamic> currentSession;

  const CurrentSessionDataState(this.currentSession);

  @override
  List<Object> get props => [currentSession];
}

class CurrentSessionDataErrorState extends RoomState {}
