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
      yield currentState.copyWith(
        loaded: false,
        loading: true,
        error: null,
      );

      try {
        final Response response =
            await _apiProvider.requestOtp(currentState.mobile);

        final results = response.data;

        yield currentState.copyWith(
          loaded: true,
          loading: false,
          serverOtp: results['otp'],
        );

        event.callback(results);
      } catch (error) {
        yield currentState.copyWith(
          error: error.response.data,
          loaded: true,
          loading: false,
        );

        event.callback(error);
      }
    }

    if (event is VerifyOtp) {
      yield currentState.copyWith(
        loaded: false,
        loading: true,
        error: null,
      );

      try {
        final Response response = await _apiProvider.verifyOtp(
          currentState.mobile,
          currentState.clientOtp,
        );

        final results = response.data;

        yield currentState.copyWith(
          loaded: true,
          loading: false,
        );

        event.callback(results);
      } catch (error) {
        yield currentState.copyWith(
          error: error.response.data,
          loaded: true,
          loading: false,
        );

        event.callback(error);
      }
    }
  }
}
