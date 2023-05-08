import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cinema_application/src/api/api_service.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final ApiService apiService;

  RegistrationBloc({required this.apiService}) : super(RegistrationInitial());

  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationWithOtpRequested) {
      yield* _mapRegistrationWithOtpRequestedToState(event);
    }
  }

  Stream<RegistrationState> _mapRegistrationWithOtpRequestedToState(
      RegistrationWithOtpRequested event) async* {
    yield RegistrationLoading();
    try {
      final registrationResult =
          await ApiService.registrationWithOtp(event.phone);
      if (registrationResult['success'] == true) {
        yield RegistrationSuccess();
      } else {
        yield RegistrationFailure(
            errorMessage: registrationResult['errorMessage']);
      }
    } catch (e) {
      yield RegistrationFailure(errorMessage: e.toString());
    }
  }
}
