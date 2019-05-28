import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';

class ThemeBloc extends ChangeNotifier {
  DefaultTheme defaultTheme = DefaultTheme.defaultTheme("black");

  setTheme(DefaultTheme theme) {
    defaultTheme = theme;
    notifyListeners();
  }

  get theme => defaultTheme;
}
