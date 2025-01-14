import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/resources/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error = const {};
  User user;
  int tabIndex = 2;
  List<String> adsKeywords = [];

  setState({
    bool loading,
    bool loaded,
    Map error,
    User user,
    int tabIndex,
    int adsKeywords,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.user = user ?? this.user;
    this.tabIndex = tabIndex ?? this.tabIndex;
    this.adsKeywords = adsKeywords ?? this.adsKeywords;

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

      setUser(results['user']);
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

      setUser(results['user']);
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  setAdImpression(String type) async {
    await _apiProvider.setAdImpression(type);
  }

  followUser(followingId, guestId) async {
    try {
      final Response response = await _apiProvider.followUser(
        followingId,
        guestId,
      );

      final results = response.data;

      setState(
        user: User.fromMap(results['user']),
        error: null,
        loading: false,
        loaded: true,
      );

      return User.fromMap(results['guest']);
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }

  unfollowUser(followingId, guestId) async {
    try {
      final Response response = await _apiProvider.unfollowUser(
        followingId,
        guestId,
      );

      final results = response.data;

      setState(
        user: User.fromMap(results['user']),
        error: null,
        loading: false,
        loaded: true,
      );

      return User.fromMap(results['guest']);
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }

  getAdsKeywords() async {
    try {
      final Response response = await _apiProvider.getAdsKeywords();
      final results = response.data;

      setUser(results['user']);
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }

  uploadAvatar(formdata) async {
    try {
      final Response response = await _apiProvider.uploadAvatar(formdata);
      final results = response.data;

      setUser(results['user']);
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }

  getAuthUser() async {
    try {
      final Response response = await _apiProvider.getAuthUser();
      final results = response.data;

      setUser(results['user']);
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }

  getGuestUser(int userId) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getGuestUser(userId);
      final results = response.data;

      setState(
        error: null,
        loading: false,
        loaded: true,
      );

      return User.fromMap(results['user']);
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

  setUser(Map userData) {
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
