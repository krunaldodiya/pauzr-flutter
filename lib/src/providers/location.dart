import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/location.dart';
import 'package:pauzr/src/resources/api.dart';

class LocationBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  List<Location> locations = [];

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    List<Location> locations,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.locations = locations ?? this.locations;

    notifyListeners();
  }

  getLocations() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getLocations();
      final results = response.data;

      setState(
        locations: Location.fromList(results['locations']),
        loading: false,
        loaded: true,
      );
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
