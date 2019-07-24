import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/resources/api.dart';

class LotteryBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  List lotteries = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    List lotteries,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.lotteries = lotteries ?? this.lotteries;

    notifyListeners();
  }

  getLotteries(selectedLotteryIndex) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getLotteries(
        selectedLotteryIndex,
      );

      final results = response.data;

      setState(
        lotteries: results['lotteries'],
        loading: false,
        loaded: true,
      );
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
