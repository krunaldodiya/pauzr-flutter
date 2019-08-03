import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/lottery.dart';
import 'package:pauzr/src/resources/api.dart';

class LotteryBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error = const {};
  bool busy;
  int page = 1;
  int lastPage;
  int total;
  List lotteries = [];
  List<Lottery> lotteryWinners = [];
  List<Lottery> lotteryHistory = [];

  setState({
    bool loading,
    bool loaded,
    Map error,
    bool busy,
    int page,
    int lastPage,
    int total,
    List lotteries,
    List<Lottery> lotteryWinners,
    List<Lottery> lotteryHistory,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.busy = busy ?? this.busy;
    this.page = page ?? this.page;
    this.lastPage = lastPage ?? this.lastPage;
    this.total = total ?? this.total;
    this.lotteries = lotteries ?? this.lotteries;
    this.lotteryWinners = lotteryWinners ?? this.lotteryWinners;
    this.lotteryHistory = lotteryHistory ?? this.lotteryHistory;

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

  getLotteryWinners({reload: false}) async {
    if (busy == true) return false;
    if (reload == true && page == lastPage) return false;

    if (reload == false) {
      setState(loading: true, loaded: false, page: 1, lotteryWinners: []);
    } else {
      setState(busy: true, page: page + 1);
    }

    try {
      final Response response = await _apiProvider.getLotteryWinners(page);
      final results = response.data;
      final List<Lottery> lotteryWinnersData = Lottery.fromList(
        results['lottery_winners']['data'],
      );
      final int lastPage = results['lottery_winners']['last_page'];

      setState(
        lotteryWinners: lotteryWinners..addAll(lotteryWinnersData),
        lastPage: lastPage,
        loading: false,
        loaded: true,
        busy: false,
      );

      return results;
    } catch (error) {
      setState(
        error: error.response.data,
        loading: false,
        loaded: true,
        busy: false,
      );
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
