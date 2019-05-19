abstract class ThemeEvent {}

class SetTheme extends ThemeEvent {
  String theme;

  SetTheme({this.theme});
}
