import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/wallet_transaction.dart';
import 'package:pauzr/src/resources/api.dart';

class WalletBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  int sum;
  int avg;
  List<WalletTransaction> walletHistory = [];

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    int sum,
    int avg,
    List<WalletTransaction> walletHistory,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.sum = sum ?? this.sum;
    this.avg = avg ?? this.avg;
    this.walletHistory = walletHistory ?? this.walletHistory;

    notifyListeners();
  }

  getWalletHistory() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getWalletHistory();
      final results = response.data;
      final List<WalletTransaction> walletHistoryData =
          WalletTransaction.fromList(results['history']);

      setState(
        sum: results['sum'],
        avg: results['avg'],
        walletHistory: walletHistoryData,
        loading: false,
        loaded: true,
      );

      return walletHistoryData;
    } catch (e) {
      setState(
        error: e.response.data,
        loading: false,
        loaded: true,
      );
    }
  }
}
