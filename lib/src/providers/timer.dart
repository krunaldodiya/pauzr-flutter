import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/resources/api.dart';

class TimerBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  int duration;

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    int duration,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.duration = duration ?? this.duration;

    notifyListeners();
  }

  setTimer(duration) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.setTimer(duration);
      final results = response.data;

      setState(duration: duration, loading: false, loaded: true);
      return results;
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
