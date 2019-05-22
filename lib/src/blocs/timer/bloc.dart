import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:pauzr/src/blocs/timer/event.dart';
import 'package:pauzr/src/blocs/timer/state.dart';
import 'package:pauzr/src/resources/api.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final ApiProvider _apiProvider = ApiProvider();

  void setTimer(duration, callback) {
    dispatch(SetTimer(duration: duration, callback: callback));
  }

  @override
  TimerState get initialState => TimerState.initial();

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is SetTimer) {
      yield currentState.copyWith(
        loaded: false,
        loading: true,
        error: null,
      );

      try {
        final Response response = await _apiProvider.setTimer(event.duration);
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
