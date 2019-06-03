import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/group.dart';
import 'package:pauzr/src/resources/api.dart';

class GroupBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  List<Group> groups = [];

  setState({
    bool loading,
    bool loaded,
    Map error,
    List<Group> groups,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = error ?? this.error;
    this.groups = groups ?? this.groups;

    notifyListeners();
  }

  getGroups() async {
    setState(loading: true);

    try {
      final Response response = await _apiProvider.getGroups();
      final results = response.data;

      setState(
        groups: Group.fromList(results['groups']),
        loading: false,
        loaded: true,
      );
    } catch (e) {
      setState(
        error: e.response.data,
        loading: false,
        loaded: true,
      );
    }
  }
}
