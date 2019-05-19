import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/themes/black/black.dart';
import 'package:pauzr/src/atp/themes/red/red.dart';

class ThemeProvider {
  static Map themes = {
    "red": Red(),
    "black": Black(),
  };

  static defaultTheme([name = "black"]) {
    return DefaultTheme.defaultTheme(themes[name]);
  }
}

class DefaultTheme {
  Intro1 intro1;
  Intro2 intro2;
  Intro3 intro3;
  Timer timer;

  DefaultTheme({
    @required this.intro1,
    @required this.intro2,
    @required this.intro3,
    @required this.timer,
  });

  static DefaultTheme defaultTheme(theme) {
    return DefaultTheme(
      intro1: theme.intro1,
      intro2: theme.intro2,
      intro3: theme.intro3,
      timer: theme.timer,
    );
  }
}