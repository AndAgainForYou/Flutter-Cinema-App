import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cinema_application/src/api/api_service.dart';
import 'package:flutter_cinema_application/src/token/token_rep.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final TokenRepository _tokenManager;
  PaymentBloc(this._tokenManager) : super(PaymentInitial()) {
    on<GetBookTicketEvent>((event, emit) async {
      final token = await _tokenManager.getToken();
      if (token != null) {
        try {
          await ApiService.bookTicket(token, event.seats, event.sessionId);
          emit(GetBookTicketState());
        } catch (error) {
          emit(GetBookTicketErrorState());
        }
      }
    });

    on<GetBuyTicketEvent>((event, emit) async {
      final token = await _tokenManager.getToken();
      if (token != null) {
        try {
          await ApiService.buyTicket(token, event.seats, event.sessionId,
              event.email, event.cardNumber, event.expirationDate, event.cvv);
          emit(GetBuyTicketState());
        } catch (error) {
          emit(GetBuyTicketErrorState());
        }
      }
    });
  }
}
