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

  addParticipants(groupId, participants) async {
    setState(loading: true);

    try {
      final Response response =
          await _apiProvider.addParticipants(groupId, participants);

      final results = response.data;

      setState(
        groups: Group.fromList(results['group']),
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

  createGroup(name, description, photo) async {
    setState(loading: true);

    try {
      final Response response =
          await _apiProvider.createGroup(name, description, photo);

      final results = response.data;
      final groupData = groups..add(Group.fromList(results['group']));

      setState(
        groups: groupData,
        loading: false,
        loaded: true,
      );

      return groupData;
    } catch (error) {
      setState(
        error: error.response.data,
        loading: false,
        loaded: true,
      );
    }
  }

  editGroup(groupId, name, description, photo) async {
    setState(loading: true);

    try {
      final Response response =
          await _apiProvider.editGroup(groupId, name, description, photo);

      final results = response.data;
      final groupData = groups
          .where((group) => group.id == groupId)
          .map((group) => Group.fromList(results['group']))
          .toList();

      setState(
        groups: groupData,
        loading: false,
        loaded: true,
      );

      return groupData;
    } catch (error) {
      setState(
        error: error.response.data,
        loading: false,
        loaded: true,
      );
    }
  }

  exitGroup(groupId, userId) async {
    setState(loading: true);

    try {
      await _apiProvider.exitGroup(groupId, userId);

      setState(
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
