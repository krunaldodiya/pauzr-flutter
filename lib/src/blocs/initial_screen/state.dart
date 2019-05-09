import 'package:pauzr/src/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class InitialScreenState {
  final bool loaded;
  final User user;

  InitialScreenState({
    @required this.loaded,
    @required this.user,
  });

  factory InitialScreenState.initial() {
    return InitialScreenState(
      loaded: false,
      user: null,
    );
  }

  InitialScreenState copyWith({
    bool loaded,
    User user,
  }) {
    return InitialScreenState(
      loaded: loaded ?? this.loaded,
      user: user ?? this.user,
    );
  }
}
