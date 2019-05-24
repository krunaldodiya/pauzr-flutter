import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:pauzr/src/blocs/group/event.dart';
import 'package:pauzr/src/blocs/group/state.dart';
import 'package:pauzr/src/resources/api.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final ApiProvider _apiProvider = ApiProvider();

  void createGroup(name, description, photo, callback) {
    dispatch(
      CreateGroup(
        name: name,
        description: description,
        photo: photo,
        callback: callback,
      ),
    );
  }

  void editGroup(groupId, name, description, photo, callback) {
    dispatch(
      EditGroup(
        groupId: groupId,
        name: name,
        description: description,
        photo: photo,
        callback: callback,
      ),
    );
  }

  void exitGroup(groupId, callback) {
    dispatch(
      ExitGroup(
        groupId: groupId,
        callback: callback,
      ),
    );
  }

  void addParticipants(groupId, participants, callback) {
    dispatch(
      AddParticipants(
        groupId: groupId,
        participants: participants,
        callback: callback,
      ),
    );
  }

  @override
  GroupState get initialState => GroupState.initial();

  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    if (event is CreateGroup) {
      yield currentState.copyWith(
        loaded: false,
        loading: true,
        error: null,
      );

      try {
        final Response response = await _apiProvider.createGroup(
          event.name,
          event.description,
          event.photo,
        );

        final results = response.data;

        yield currentState.copyWith(
          loaded: true,
          loading: false,
        );

        event.callback(results);
      } catch (error) {
        yield currentState.copyWith(
          error: error.response.data,
          loaded: true,
          loading: false,
        );

        event.callback(error);
      }
    }

    if (event is EditGroup) {
      yield currentState.copyWith(
        loaded: false,
        loading: true,
        error: null,
      );

      try {
        final Response response = await _apiProvider.editGroup(
          event.groupId,
          event.name,
          event.description,
          event.photo,
        );

        final results = response.data;

        yield currentState.copyWith(
          loaded: true,
          loading: false,
        );

        event.callback(results);
      } catch (error) {
        yield currentState.copyWith(
          error: error.response.data,
          loaded: true,
          loading: false,
        );

        event.callback(error);
      }
    }

    if (event is ExitGroup) {
      yield currentState.copyWith(
        loaded: false,
        loading: true,
        error: null,
      );

      try {
        final Response response = await _apiProvider.exitGroup(event.groupId);
        final results = response.data;

        yield currentState.copyWith(
          loaded: true,
          loading: false,
        );

        event.callback(results);
      } catch (error) {
        yield currentState.copyWith(
          error: error.response.data,
          loaded: true,
          loading: false,
        );

        event.callback(error);
      }
    }

    if (event is AddParticipants) {
      yield currentState.copyWith(
        loaded: false,
        loading: true,
        error: null,
      );

      try {
        final Response response = await _apiProvider.addParticipants(
          event.groupId,
          event.participants,
        );

        final results = response.data;

        yield currentState.copyWith(
          loaded: true,
          loading: false,
        );

        event.callback(results);
      } catch (error) {
        yield currentState.copyWith(
          error: error.response.data,
          loaded: true,
          loading: false,
        );

        event.callback(error);
      }
    }
  }
}
