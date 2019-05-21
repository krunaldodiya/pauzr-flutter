import 'package:meta/meta.dart';
import 'package:pauzr/src/models/group.dart';

@immutable
class GroupState {
  final bool loading;
  final bool loaded;
  final Map error;
  final List<Group> groups;

  GroupState({
    @required this.loading,
    @required this.loaded,
    @required this.error,
    @required this.groups,
  });

  factory GroupState.initial() {
    return GroupState(
      loading: false,
      loaded: false,
      error: null,
      groups: List<Group>(),
    );
  }

  GroupState copyWith({
    bool loading,
    bool loaded,
    Map error,
    List groups,
  }) {
    return GroupState(
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
      error: error ?? this.error,
      groups: groups ?? this.groups,
    );
  }
}
