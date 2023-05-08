import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cinema_application/src/api/api_service.dart';
import 'package:flutter_cinema_application/src/token/token_rep.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final TokenRepository _tokenManager;

  ProfileBloc(this._tokenManager) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      try {
        final token = await _tokenManager.getToken();
        if (token != null) {
          final user = await ApiService.getUser(token);
          emit(UserDataLoadedState(user));
        } else {
        }
      } catch (_) {
      }
    });

    on<GetUserTicketsEvent>((event, emit) async {
      final token = await _tokenManager.getToken();
      if (token != null) {
        try {
          final tickets = await ApiService.getTickets(token);
          emit(UserDataTicketsState(tickets));
        } catch (error) {
          emit(UserDataTicketsErrorState());
        }
      }
    });
  }
}
