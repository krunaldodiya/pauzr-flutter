import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/blocs/theme/event.dart';
import 'package:pauzr/src/blocs/theme/state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  void setTheme(theme) {
    dispatch(SetTheme(theme: theme));
  }

  @override
  ThemeState get initialState => ThemeState.initial();

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is SetTheme) {
      Map themes = DefaultTheme.themes;
      DefaultTheme defaultTheme = DefaultTheme.defaultTheme(
        themes[event.theme],
      );

      yield currentState.copyWith(theme: defaultTheme);
    }
  }
}
