import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/themes/black.dart';
import 'package:pauzr/src/atp/themes/red.dart';

class ThemeProvider {
  static Map options = {
    "default": "black",
    "themes": {
      "red": Red(),
      "black": Black(),
    }
  };

  static Map _themes = options["themes"];
  static String _default = options["default"];
  static var theme = _themes[_default];

  static DefaultTheme defaultTheme = DefaultTheme.defaultTheme(theme);
}

class DefaultTheme {
  Intro1 intro1;
  Intro2 intro2;
  Intro3 intro3;

  DefaultTheme({
    @required this.intro1,
    @required this.intro2,
    @required this.intro3,
  });

  static DefaultTheme defaultTheme(theme) {
    return DefaultTheme(
      intro1: theme.intro1,
      intro2: theme.intro2,
      intro3: theme.intro3,
    );
  }
}
