import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:pauzr/src/blocs/group/event.dart';
import 'package:pauzr/src/blocs/group/state.dart';
import 'package:pauzr/src/resources/api.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final ApiProvider _apiProvider = ApiProvider();

  void createGroup(name, callback) {
    dispatch(CreateGroup(name: name, callback: callback));
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
        final Response response = await _apiProvider.createGroup(event.name);
        final results = response.data;

        yield currentState.copyWith(
          loaded: true,
          loading: false,
          error: null,
        );

        event.callback(results);
      } catch (error) {
        yield currentState.copyWith(
          error: error.response.data['errors'],
          loaded: true,
          loading: false,
        );

        event.callback(false);
      }
    }
  }
}
