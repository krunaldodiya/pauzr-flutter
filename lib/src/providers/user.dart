import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  User user;

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    User user,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.user = user ?? this.user;

    notifyListeners();
  }

  onChangeData(String key, String value, User userData) {
    setState(
      user: userData.copyWith({key: value.length > 0 ? value : null}),
      error: null,
    );
  }

  updateProfile() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.updateProfile(user);
      final results = response.data;

      setAuthUser(results['user']);
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  getAuthUser() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getAuthUser();
      final results = response.data;

      setAuthToken(results['access_token']);
      setAuthUser(results['user']);
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  setAuthToken(String token) async {
    if (token != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("authToken", token);
    }
  }

  setAuthUser(Map userData) {
    setState(
      user: User.fromMap(userData),
      error: null,
      loading: false,
      loaded: true,
    );
  }

  removeAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("authToken");
    prefs.remove("defaultTheme");
    prefs.remove("contacts");

    setState(
      user: null,
      error: null,
      loading: false,
      loaded: true,
    );
  }
}
