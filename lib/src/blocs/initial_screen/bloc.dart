import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pauzr/src/blocs/initial_screen/event.dart';
import 'package:pauzr/src/blocs/initial_screen/state.dart';
import 'package:pauzr/src/models/user.dart';

class InitialScreenBloc extends Bloc<InitialScreenEvent, InitialScreenState> {
  void setAuthUser(User user) {
    dispatch(SetAuthUser(user: user));
  }

  @override
  InitialScreenState get initialState => InitialScreenState.initial();

  @override
  Stream<InitialScreenState> mapEventToState(InitialScreenEvent event) async* {
    if (event is SetAuthUser) {
      yield currentState.copyWith(loaded: true, user: event.user);
    }
  }
}
