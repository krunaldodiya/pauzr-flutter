import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';

class ThemeBloc extends ChangeNotifier {
  bool loading;
  bool loaded;
  DefaultTheme defaultTheme;

  setState({
    bool loading,
    bool loaded,
    DefaultTheme defaultTheme,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.defaultTheme = defaultTheme ?? this.defaultTheme;

    notifyListeners();
  }

  setTheme(DefaultTheme theme) {
    setState(defaultTheme: theme, loading: false, loaded: true);
  }

  get theme => defaultTheme;
}
