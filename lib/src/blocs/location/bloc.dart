import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
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
      yield currentState.copyWith(loading: true);

      try {
        final response = await _apiProvider.getLocations();
        final results = json.decode(response.body);
        final List locations = results['locations'];

        if (locations.isNotEmpty) {
          yield currentState.copyWith(
            locations: Location.fromList(locations),
            loaded: true,
            loading: false,
          );
        }
      } catch (e) {
        yield currentState.copyWith(
          error: "Error, Something bad happened.",
          loading: false,
        );
      }
    }
  }
}
