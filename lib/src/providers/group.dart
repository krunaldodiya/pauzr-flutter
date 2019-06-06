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
    Map error: const {},
    List<Group> groups,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.groups = groups ?? this.groups;

    notifyListeners();
  }

  getGroups() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getGroups();

      final results = response.data;
      final groupData = Group.fromList(results['groups']);

      setState(
        groups: groupData,
        loading: false,
        loaded: true,
      );

      return groupData;
    } catch (e) {
      setState(
        error: e.response.data,
        loading: false,
        loaded: true,
      );
    }
  }

  addParticipants(groupId, participants) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.addParticipants(
        groupId,
        participants,
      );

      final results = response.data;
      final currentGroup = Group.fromMap(results['group']);

      final groupData = groups
          .map((group) => group.id == currentGroup.id ? currentGroup : group)
          .toList();

      setState(
        groups: groupData,
        loading: false,
        loaded: true,
      );

      return currentGroup;
    } catch (e) {
      setState(
        error: e.response.data,
        loading: false,
        loaded: true,
      );
    }
  }

  createGroup(name, description, photo) async {
    setState(loading: true, loaded: false);

    try {
      final Response response =
          await _apiProvider.createGroup(name, description, photo);

      final results = response.data;
      final currentGroup = Group.fromMap(results['group']);

      final groupData = groups..add(currentGroup);

      setState(
        groups: groupData,
        loading: false,
        loaded: true,
      );

      return currentGroup;
    } catch (error) {
      setState(
        error: error.response.data,
        loading: false,
        loaded: true,
      );
    }
  }

  editGroup(groupId, name, description, photo) async {
    setState(loading: true, loaded: false);

    try {
      final Response response =
          await _apiProvider.editGroup(groupId, name, description, photo);

      final results = response.data;
      final currentGroup = Group.fromMap(results['group']);

      final groupData = groups
          .map((group) => group.id == currentGroup.id ? currentGroup : group)
          .toList();

      setState(
        groups: groupData,
        loading: false,
        loaded: true,
      );

      return currentGroup;
    } catch (error) {
      setState(
        error: error.response.data,
        loading: false,
        loaded: true,
      );
    }
  }

  exitGroup(groupId, userId) async {
    setState(loading: true, loaded: false);

    try {
      await _apiProvider.exitGroup(groupId, userId);

      final groupData = groups..removeWhere((group) => group.id == groupId);

      setState(
        groups: groupData,
        loading: false,
        loaded: true,
      );

      return groupData;
    } catch (e) {
      setState(
        error: e.response.data,
        loading: false,
        loaded: true,
      );
    }
  }

  deleteGroup(groupId, userId) async {
    setState(loading: true, loaded: false);

    try {
      await _apiProvider.deleteGroup(groupId, userId);

      final groupData = groups..removeWhere((group) => group.id == groupId);

      setState(
        groups: groupData,
        loading: false,
        loaded: true,
      );

      return groupData;
    } catch (e) {
      setState(
        error: e.response.data,
        loading: false,
        loaded: true,
      );
    }
  }

  removeParticipants(groupId, userId) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.removeParticipants(
        groupId,
        userId,
      );

      final results = response.data;
      final currentGroup = Group.fromMap(results['group']);

      final groupData = groups
          .map((group) => group.id == currentGroup.id ? currentGroup : group)
          .toList();

      setState(
        groups: groupData,
        loading: false,
        loaded: true,
      );

      return groupData;
    } catch (e) {
      setState(
        error: e.response.data,
        loading: false,
        loaded: true,
      );
    }
  }
}
