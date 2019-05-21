import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:pauzr/src/blocs/otp/event.dart';
import 'package:pauzr/src/blocs/otp/state.dart';
import 'package:pauzr/src/resources/api.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final ApiProvider _apiProvider = ApiProvider();

  void onChangeMobile(mobile) {
    dispatch(ChangeMobile(mobile: mobile));
  }

  void onChangeOtp(clientOtp) {
    dispatch(ChangeOtp(clientOtp: int.parse(clientOtp)));
  }

  void requestOtp(callback) {
    dispatch(RequestOtp(callback: callback));
  }

  void verifyOtp(callback) {
    dispatch(VerifyOtp(callback: callback));
  }

  @override
  OtpState get initialState => OtpState.initial();

  @override
  Stream<OtpState> mapEventToState(
    OtpEvent event,
  ) async* {
    if (event is ChangeMobile) {
      yield currentState.copyWith(mobile: event.mobile, error: {});
    }

    if (event is ChangeOtp) {
      yield currentState.copyWith(clientOtp: event.clientOtp, error: {});
    }

    if (event is RequestOtp) {
      yield currentState.copyWith(loading: true);

      try {
        final Response response =
            await _apiProvider.requestOtp(currentState.mobile);

        final results = response.data;

        if (results['otp'] != null) {
          yield currentState.copyWith(
            loaded: true,
            loading: false,
            error: null,
            serverOtp: results['otp'],
          );

          event.callback(true);
        } else {
          yield currentState.copyWith(
            loaded: true,
            loading: false,
            error: results['errors'],
          );
          event.callback(false);
        }
      } catch (e) {
        yield currentState.copyWith(
          loaded: true,
          loading: false,
          error: {"error": "Error, Something bad happened."},
        );

        event.callback(false);
      }
    }

    if (event is VerifyOtp) {
      yield currentState.copyWith(loading: true);

      try {
        final Response response = await _apiProvider.verifyOtp(
          currentState.mobile,
          currentState.clientOtp,
        );

        final results = response.data;

        if (results['user'] != null) {
          yield currentState.copyWith(
            loaded: true,
            loading: false,
            error: null,
          );

          event.callback(results);
        } else {
          yield currentState.copyWith(
            loaded: true,
            loading: false,
            error: results['errors'],
          );

          event.callback(false);
        }
      } catch (e) {
        yield currentState.copyWith(
          loaded: true,
          loading: false,
          error: {"error": "Error, Something bad happened."},
        );

        event.callback(false);
      }
    }
  }
}
