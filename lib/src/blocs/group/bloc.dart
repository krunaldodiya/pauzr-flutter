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
      yield currentState.copyWith(loaded: false, loading: true);

      try {
        final Response response = await _apiProvider.createGroup(event.name);
        final results = response.data;

        if (results['success'] == true) {
          event.callback(true);
        } else {
          event.callback(false);
        }

        yield currentState.copyWith(
          error: results['errors'],
          loaded: true,
          loading: false,
        );
      } catch (e) {
        yield currentState.copyWith(
          error: {"errors": "Error, Something bad happened."},
          loaded: true,
          loading: false,
        );

        event.callback(false);
      }
    }
  }
}
