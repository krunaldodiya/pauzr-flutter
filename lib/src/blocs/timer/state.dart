import 'package:meta/meta.dart';

@immutable
class TimerState {
  final bool loading;
  final bool loaded;
  final Map error;
  final int seconds;

  TimerState({
    @required this.loading,
    @required this.loaded,
    @required this.error,
    @required this.seconds,
  });

  factory TimerState.initial() {
    return TimerState(
      loading: false,
      loaded: false,
      error: null,
      seconds: null,
    );
  }

  TimerState copyWith({
    bool loading,
    bool loaded,
    Map error,
    int seconds,
  }) {
    return TimerState(
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
      error: error ?? this.error,
      seconds: seconds ?? this.seconds,
    );
  }
}
