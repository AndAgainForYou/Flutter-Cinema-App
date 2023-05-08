import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cinema_application/src/api/api_service.dart';
import 'package:flutter_cinema_application/src/token/token_rep.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final TokenRepository _tokenManager;
  RoomBloc(this._tokenManager) : super(RoomInitial()) {
    on<GetCurrentSessionEvent>((event, emit) async {
      final token = await _tokenManager.getToken();
      if (token != null) {
        try {
          final session =
              await ApiService.getCurrentSession(token, event.sessionId);
          emit(CurrentSessionDataState(session));
        } catch (error) {
          emit(CurrentSessionDataErrorState());
        }
      }
    });
  }
}
