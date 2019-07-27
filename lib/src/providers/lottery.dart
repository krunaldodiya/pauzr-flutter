import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/lottery.dart';
import 'package:pauzr/src/resources/api.dart';

class LotteryBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  List lotteries = [];
  List<Lottery> lotteryWinners = [];
  List<Lottery> lotteryHistory = [];
  int total;

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    List lotteries,
    List<Lottery> lotteryWinners,
    List<Lottery> lotteryHistory,
    int total,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.lotteries = lotteries ?? this.lotteries;
    this.lotteryWinners = lotteryWinners ?? this.lotteryWinners;
    this.lotteryHistory = lotteryHistory ?? this.lotteryHistory;
    this.total = total ?? this.total;

    notifyListeners();
  }

  setLotteries(total) async {
    List lotteries = [];

    for (var i = 0; i < total; i++) {
      lotteries.add(0);
    }

    setState(lotteries: lotteries);
  }

  withdrawAmount(amount) async {
    setState(loading: true, loaded: false);

    try {
      await _apiProvider.withdrawAmount(amount);
      setState(loading: false, loaded: true);
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  getLotteries(selectedLotteryIndex) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getLotteries(
        selectedLotteryIndex,
      );

      final results = response.data;

      setState(
        lotteries: results['lotteries'] ?? lotteries,
        loading: false,
        loaded: true,
      );

      return results;
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  getLotteryWinners() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getLotteryWinners();
      final results = response.data;

      final List<Lottery> lotteryWinners = Lottery.fromList(
        results['lottery_winners'],
      );

      setState(
        lotteryWinners: lotteryWinners,
        loading: false,
        loaded: true,
      );

      return results;
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  getLotteryHistory() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getLotteryHistory();
      final results = response.data;

      final List<Lottery> lotteryHistory = Lottery.fromList(
        results['lottery_history'],
      );

      setState(
        lotteryHistory: lotteryHistory,
        total: results['total'],
        loading: false,
        loaded: true,
      );

      return results;
    } catch (error) {
      print(error);
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
