import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/city.dart';
import 'package:pauzr/src/resources/api.dart';

class CityBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error = const {};
  List<City> cities = [];

  setState({
    bool loading,
    bool loaded,
    Map error,
    List<City> cities,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.cities = cities ?? this.cities;

    notifyListeners();
  }

  getCities() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getCities();
      final results = response.data;

      setState(
        cities: City.fromList(results['cities']),
        loading: false,
        loaded: true,
      );
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
