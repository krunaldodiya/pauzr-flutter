import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/resources/api.dart';

class CategoryBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error = const {};
  List categories = [];

  setState({
    bool loading,
    bool loaded,
    Map error,
    List categories,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.categories = categories ?? this.categories;

    notifyListeners();
  }

  getCategories() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getCategories();

      final results = response.data;

      setState(
        categories: results['categories'] ?? categories,
        loading: false,
        loaded: true,
      );

      return results;
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
