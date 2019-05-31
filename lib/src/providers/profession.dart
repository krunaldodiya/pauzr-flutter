import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/profession.dart';
import 'package:pauzr/src/resources/api.dart';

class ProfessionBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  List<Profession> professions;

  getProfessions() async {
    loading = true;

    try {
      final Response response = await _apiProvider.getProfessions();
      final results = response.data;

      professions = results['professions'];
    } catch (e) {
      error = e.response.data;
    }

    loading = false;
    loaded = true;

    notifyListeners();
  }
}
