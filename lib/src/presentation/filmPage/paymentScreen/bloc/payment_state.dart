part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class GetBookTicketState extends PaymentState {}
class GetBookTicketErrorState extends PaymentState {}

class GetBuyTicketState extends PaymentState {}
class GetBuyTicketErrorState extends PaymentState {}
