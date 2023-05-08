import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cinema_application/src/api/api_service.dart';
import 'package:flutter_cinema_application/src/token/token_rep.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
final TokenRepository _tokenManager;

  LoginBloc(this._tokenManager) : super(LoginInitial()) {
    on<SaveTokenEvent>((event, emit) async {
      try {
        final token = await ApiService.loginWithOtp(event.phone, event.otp);

        await _tokenManager.saveToken(token['accessToken']);

        emit(TokenSavedState());
      } catch (_) {
        emit(TokenErrorState());
      }
    });
  }
}
