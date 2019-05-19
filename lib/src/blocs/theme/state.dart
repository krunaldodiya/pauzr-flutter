import 'package:meta/meta.dart';
import 'package:pauzr/src/atp/default.dart';

@immutable
class ThemeState {
  final DefaultTheme theme;

  ThemeState({
    @required this.theme,
  });

  factory ThemeState.initial() {
    Map themes = DefaultTheme.themes;

    DefaultTheme defaultTheme = DefaultTheme.defaultTheme(
      themes["black"],
    );

    return ThemeState(theme: defaultTheme);
  }

  ThemeState copyWith({DefaultTheme theme}) {
    return ThemeState(
      theme: theme ?? this.theme,
    );
  }
}
