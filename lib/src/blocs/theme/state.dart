import 'package:meta/meta.dart';
import 'package:pauzr/src/atp/default.dart';

@immutable
class ThemeState {
  final DefaultTheme theme;

  ThemeState({
    @required this.theme,
  });

  factory ThemeState.initial() {
    return ThemeState(theme: null);
  }

  ThemeState copyWith({DefaultTheme theme}) {
    return ThemeState(
      theme: theme ?? this.theme,
    );
  }
}
