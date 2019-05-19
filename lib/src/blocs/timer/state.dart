import 'package:meta/meta.dart';

@immutable
class TimerState {
  final bool loading;
  final bool loaded;
  final Map error;
  final int duration;

  TimerState({
    @required this.loading,
    @required this.loaded,
    @required this.error,
    @required this.duration,
  });

  factory TimerState.initial() {
    return TimerState(
      loading: false,
      loaded: false,
      error: null,
      duration: null,
    );
  }

  TimerState copyWith({
    bool loading,
    bool loaded,
    Map error,
    int duration,
  }) {
    return TimerState(
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
      error: error ?? this.error,
      duration: duration ?? this.duration,
    );
  }
}
