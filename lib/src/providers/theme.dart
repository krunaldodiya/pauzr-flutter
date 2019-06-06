import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';

class ThemeBloc extends ChangeNotifier {
  bool loading;
  bool loaded;
  Map error;
  DefaultTheme defaultTheme;

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    DefaultTheme defaultTheme,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.defaultTheme = defaultTheme ?? this.defaultTheme;

    notifyListeners();
  }

  setTheme(DefaultTheme theme) {
    setState(defaultTheme: theme);
  }

  get theme => defaultTheme;
}
