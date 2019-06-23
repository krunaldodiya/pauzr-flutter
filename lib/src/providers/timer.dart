import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/timer.dart';
import 'package:pauzr/src/resources/api.dart';

class TimerBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  int sum;
  int avg;
  List<Timer> timerHistory = [];

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    int sum,
    int avg,
    List<Timer> timerHistory,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.sum = sum ?? this.sum;
    this.avg = avg ?? this.avg;
    this.timerHistory = timerHistory ?? this.timerHistory;

    notifyListeners();
  }

  getTimerHistory() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getTimerHistory();
      final results = response.data;
      final List<Timer> timerHistoryData = Timer.fromList(results['history']);

      setState(
        sum: results['sum'],
        avg: results['avg'],
        timerHistory: timerHistoryData,
        loading: false,
        loaded: true,
      );

      return timerHistoryData;
    } catch (e) {
      setState(
        error: e.response.data,
        loading: false,
        loaded: true,
      );
    }
  }

  setTimer(int duration) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.setTimer(duration);

      setState(loading: false, loaded: true);

      return response;
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
