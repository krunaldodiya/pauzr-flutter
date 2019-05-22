import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:pauzr/src/blocs/location/event.dart';
import 'package:pauzr/src/blocs/location/state.dart';
import 'package:pauzr/src/models/location.dart';
import 'package:pauzr/src/resources/api.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final ApiProvider _apiProvider = ApiProvider();

  void getLocation() {
    dispatch(GetLocation());
  }

  @override
  LocationState get initialState => LocationState.initial();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is GetLocation) {
      yield currentState.copyWith(
        loaded: false,
        loading: true,
        error: null,
      );

      try {
        final Response response = await _apiProvider.getLocations();
        final results = response.data;
        final List locations = results['locations'];

        yield currentState.copyWith(
          locations: Location.fromList(locations),
          loaded: true,
          loading: false,
        );
      } catch (error) {
        yield currentState.copyWith(
          error: error.response.data,
          loaded: true,
          loading: false,
        );
      }
    }
  }
}
