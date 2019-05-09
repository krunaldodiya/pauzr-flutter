import 'package:pauzr/src/models/profession.dart';
import 'package:meta/meta.dart';

@immutable
class ProfessionState {
  final bool loading;
  final bool loaded;
  final String error;
  final List<Profession> professions;

  ProfessionState({
    @required this.loading,
    @required this.loaded,
    @required this.error,
    @required this.professions,
  });

  factory ProfessionState.initial() {
    return ProfessionState(
      loading: false,
      loaded: false,
      error: null,
      professions: List<Profession>(),
    );
  }

  ProfessionState copyWith({
    bool loading,
    bool loaded,
    String error,
    List<Profession> professions,
  }) {
    return ProfessionState(
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
      error: error ?? this.error,
      professions: professions ?? this.professions,
    );
  }
}
