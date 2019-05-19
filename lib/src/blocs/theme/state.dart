import 'package:meta/meta.dart';

@immutable
class ThemeState {
  final String theme;

  ThemeState({
    @required this.theme,
  });

  factory ThemeState.initial() {
    return ThemeState(theme: null);
  }

  ThemeState copyWith({String theme}) {
    return ThemeState(
      theme: theme ?? this.theme,
    );
  }
}
