import 'package:bloc/bloc.dart';
import 'package:flutter_cinema_application/src/api/api_service.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_event.dart';
import 'package:flutter_cinema_application/src/data/bloc/data_state.dart';
import 'package:flutter_cinema_application/src/token/token_rep.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final TokenRepository _tokenManager;

  List<dynamic> _moviesData = [];

  List<dynamic> get moviesData => _moviesData;

  DataBloc(this._tokenManager) : super(DataInitial()) {
    on<GetMoviesEvent>((event, emit) async {
      final token = await _tokenManager.getToken();
      if (token != null) {
        try {
          final movies = await ApiService.getMovies(token);
          if (_moviesData.isEmpty) {
            _moviesData = movies['data'];
          }
          emit(MoviesLoadedState(movies));
        } catch (error) {
          emit(TokenErrorState());
        }
      } else {
        emit(TokenErrorState());
      }
    });

    on<GetUserTicketsEvent>((event, emit) async {
      final token = await _tokenManager.getToken();
      if (token != null) {
        try {
          final tickets = await ApiService.getTickets(token);
          emit(UserDataTicketsState(tickets));
        } catch (error) {
          emit(GetUserTicketsErrorState());
        }
      }
    });
  }
}
