import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:pauzr/src/blocs/initial_screen/bloc.dart';
import 'package:pauzr/src/blocs/user/event.dart';
import 'package:pauzr/src/blocs/user/state.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiProvider _apiProvider = ApiProvider();
  InitialScreenBloc initialScreenBloc;

  UserBloc({this.initialScreenBloc});

  void updateState(key, value) {
    dispatch(UpdateState(key: key, value: value));
  }

  void getAuthUser() {
    dispatch(GetAuthUser());
  }

  void setAuthUser(user) {
    dispatch(SetAuthUser(user: user));
  }

  void setAuthToken(token) {
    dispatch(SetAuthToken(token: token));
  }

  void removeAuth(token) {
    dispatch(SetAuthToken(token: token));
  }

  void updateProfile(callback) {
    dispatch(UpdateProfile(callback: callback));
  }

  @override
  UserState get initialState => UserState.initial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UpdateState) {
      User user = currentState.user.copyWith({event.key: event.value});
      yield currentState.copyWith(user: user, error: {});
    }

    if (event is GetAuthUser) {
      yield currentState.copyWith(
        loaded: false,
        loading: true,
        error: null,
      );

      try {
        final Response response = await _apiProvider.getAuthUser();
        final results = response.data;

        dispatch(SetAuthUser(user: results['user']));
        initialScreenBloc.setAuthUser(User.fromMap(results['user']));
      } catch (error) {
        yield currentState.copyWith(
          error: error.response.data,
          loaded: true,
          loading: false,
        );

        dispatch(RemoveAuth());
      }
    }

    if (event is UpdateProfile) {
      yield currentState.copyWith(
        loaded: false,
        loading: true,
        error: null,
      );

      try {
        final Response response =
            await _apiProvider.updateProfile(currentState.user);
        final results = response.data;

        dispatch(SetAuthUser(user: results['user']));
        event.callback(results);
      } catch (error) {
        yield currentState.copyWith(
          error: error.response.data,
          loaded: true,
          loading: false,
        );

        event.callback(error);
      }
    }

    if (event is SetAuthToken) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("authToken", event.token);
    }

    if (event is SetAuthUser) {
      yield currentState.copyWith(
        loaded: true,
        loading: false,
        user: User.fromMap(event.user),
      );
    }

    if (event is RemoveAuth) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove("authToken");

      yield currentState.copyWith(
        loaded: true,
        loading: false,
        user: null,
      );
    }
  }
}
