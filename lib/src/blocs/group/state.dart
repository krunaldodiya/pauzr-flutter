import 'package:meta/meta.dart';

@immutable
class GroupState {
  final bool loading;
  final bool loaded;
  final Map error;
  final String name;

  GroupState({
    @required this.loading,
    @required this.loaded,
    @required this.error,
    @required this.name,
  });

  factory GroupState.initial() {
    return GroupState(
      loading: false,
      loaded: false,
      error: null,
      name: null,
    );
  }

  GroupState copyWith({
    bool loading,
    bool loaded,
    Map error,
    int name,
  }) {
    return GroupState(
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
      error: error ?? this.error,
      name: name ?? this.name,
    );
  }
}
