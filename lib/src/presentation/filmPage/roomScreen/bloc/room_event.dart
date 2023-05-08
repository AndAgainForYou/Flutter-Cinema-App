part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentSessionEvent extends RoomEvent {
  final int sessionId;

  const GetCurrentSessionEvent(this.sessionId);
}

