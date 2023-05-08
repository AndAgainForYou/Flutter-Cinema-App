import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cinema_application/src/api/api_service.dart';
import 'package:flutter_cinema_application/src/token/token_rep.dart';

part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final TokenRepository _tokenManager;
  SessionsBloc(this._tokenManager) : super(SessionsInitial()) {
    on<GetSessionsEvent>((event, emit) async {
      final token = await _tokenManager.getToken();
      if (token != null) {
        try {
          final sessions = await ApiService.getSessions(token, event.movieId);
          emit(SessionsDataState(sessions));
        } catch (error) {
          emit(SessionsDataErrorState());
        }
      }
    });
  }
}
