import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/location.dart';
import 'package:pauzr/src/resources/api.dart';

class LocationBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  List<Location> locations;

  getLocations() async {
    loading = true;

    try {
      final Response response = await _apiProvider.getLocations();
      final results = response.data;

      locations = results['locations'];
    } catch (e) {
      error = e.response.data;
    }

    loading = false;
    loaded = true;

    notifyListeners();
  }
}
