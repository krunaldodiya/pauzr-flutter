import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';

class ThemeBloc extends ChangeNotifier {
  DefaultTheme defaultTheme = DefaultTheme.defaultTheme("black");

  setTheme(theme) {
    defaultTheme = DefaultTheme.defaultTheme(theme);
    notifyListeners();
  }

  get theme => defaultTheme;
}
