import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:pauzr/src/blocs/timer/event.dart';
import 'package:pauzr/src/blocs/timer/state.dart';
import 'package:pauzr/src/resources/api.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final ApiProvider _apiProvider = ApiProvider();

  void setTimer(seconds, callback) {
    dispatch(SetTimer(seconds: seconds, callback: callback));
  }

  @override
  TimerState get initialState => TimerState.initial();

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is SetTimer) {
      yield currentState.copyWith(loaded: false, loading: true);

      try {
        final response = await _apiProvider.setTimer(event.seconds);
        final results = json.decode(response.body);

        if (results['success'] == true) {
          event.callback(true);
        } else {
          event.callback(false);
        }

        yield currentState.copyWith(
          error: results['errors'],
          loaded: true,
          loading: false,
        );
      } catch (e) {
        yield currentState.copyWith(
          error: {"errors": "Error, Something bad happened."},
          loaded: true,
          loading: false,
        );

        event.callback(false);
      }
    }
  }
}
