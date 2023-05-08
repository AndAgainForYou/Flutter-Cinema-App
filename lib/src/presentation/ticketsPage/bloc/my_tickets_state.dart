part of 'my_tickets_bloc.dart';

abstract class MyTicketsState extends Equatable {
  const MyTicketsState();
  
  @override
  List<Object> get props => [];
}

class MyTicketsInitial extends MyTicketsState {}
