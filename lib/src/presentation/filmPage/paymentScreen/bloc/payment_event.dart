part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class GetBookTicketEvent extends PaymentEvent {
  final int sessionId;
  final List<int> seats;

  const GetBookTicketEvent(this.sessionId, this.seats);
}

class GetBuyTicketEvent extends PaymentEvent {
  final List<int> seats;
  final int sessionId;
  final String email;
  final String cardNumber;
  final String expirationDate;
  final String cvv;

  const GetBuyTicketEvent(this.sessionId, this.seats, this.email,
      this.cardNumber, this.expirationDate, this.cvv);
}