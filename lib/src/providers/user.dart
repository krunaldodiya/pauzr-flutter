import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading = false;
  bool loaded = false;
  Map error;
  User user;

  updateProfile() async {
    loading = true;

    try {
      final Response response = await _apiProvider.updateProfile(user);
      final results = response.data;

      setAuthUser(results['user']);
    } catch (e) {
      error = e.response.data;
    }

    loading = false;
    loaded = true;

    notifyListeners();
  }

  getAuthUser() async {
    loading = true;

    try {
      final Response response = await _apiProvider.getAuthUser();
      final results = response.data;

      setAuthToken(results['access_token']);
      setAuthUser(results['user']);
    } catch (e) {
      error = e.response.data;
    }

    loading = false;
    loaded = true;

    notifyListeners();
  }

  setAuthToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("authToken", token);
  }

  setAuthUser(Map userData) {
    final User authUser = User.fromMap(userData);

    user = authUser;
  }

  removeAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("authToken");
    prefs.remove("defaultTheme");
    prefs.remove("contacts");

    user = null;
  }
}
