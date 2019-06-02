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

  getGroups() async {
    loading = true;

    try {
      final Response response = await _apiProvider.getGroups();
      final results = response.data;

      groups = Group.fromList(results['groups']);
    } catch (e) {
      error = e.response.data;
    }

    loading = false;
    loaded = true;

    notifyListeners();
  }
}
