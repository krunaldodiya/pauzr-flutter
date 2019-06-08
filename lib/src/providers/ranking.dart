import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/ranking.dart';
import 'package:pauzr/src/resources/api.dart';

class RankingBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  List<Ranking> rankings = [];
  int minutesSaved;
  int pointsEarned;

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    List rankings,
    int minutesSaved,
    int pointsEarned,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.rankings = rankings ?? this.rankings;
    this.minutesSaved = minutesSaved ?? this.minutesSaved;
    this.pointsEarned = pointsEarned ?? this.pointsEarned;

    notifyListeners();
  }

  getRankings(period, groupId) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getRankings(period, groupId);
      final results = response.data;

      setState(
        rankings: Ranking.fromList(results['rankings']),
        minutesSaved: results['minutes_saved'],
        pointsEarned: results['points_earned'],
        loading: false,
        loaded: true,
      );
      return results;
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
