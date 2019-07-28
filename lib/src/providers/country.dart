import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/country.dart';
import 'package:pauzr/src/resources/api.dart';

class CountryBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error = const {};
  List<Country> countries = [];

  setState({
    bool loading,
    bool loaded,
    Map error,
    List<Country> countries,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.countries = countries ?? this.countries;

    notifyListeners();
  }

  getCountries() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getCountries();
      final results = response.data;

      setState(
        countries: Country.fromList(results['countries']),
        loading: false,
        loaded: true,
      );
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
