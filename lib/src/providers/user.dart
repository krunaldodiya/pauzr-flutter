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
  int tabIndex = 1;

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    User user,
    int tabIndex,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.user = user ?? this.user;
    this.tabIndex = tabIndex ?? this.tabIndex;

    notifyListeners();
  }

  onChangeData(String key, dynamic value, User userData) {
    setState(
      user: userData.copyWith({key: value == "" ? null : value}),
      error: null,
    );
  }

  createProfile(User user) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.updateProfile({
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "dob": user.dob,
        "gender": user.gender,
        "country_id": user.country != null ? user.country.id : null,
        "state_id": user.state != null ? user.state.id : null,
        "city_id": user.city != null ? user.city.id : null,
      });

      final results = response.data;

      setAuthUser(results['user']);
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  updateProfile(User user) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.updateProfile({
        "id": user.id,
        "name": user.name,
        "dob": user.dob,
        "gender": user.gender,
        "country_id": user.country != null ? user.country.id : null,
        "state_id": user.state != null ? user.state.id : null,
        "city_id": user.city != null ? user.city.id : null,
      });

      final results = response.data;

      setAuthUser(results['user']);
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  getAuthUser() async {
    try {
      final Response response = await _apiProvider.getAuthUser();
      final results = response.data;

      await setAuthUser(results['user']);
    } catch (error) {
      setState(loading: false, loaded: true);
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
