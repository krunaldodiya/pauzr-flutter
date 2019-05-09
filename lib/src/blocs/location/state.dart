import 'package:pauzr/src/models/location.dart';
import 'package:meta/meta.dart';

@immutable
class LocationState {
  final bool loading;
  final bool loaded;
  final String error;
  final List<Location> locations;

  LocationState({
    @required this.loading,
    @required this.loaded,
    @required this.error,
    @required this.locations,
  });

  factory LocationState.initial() {
    return LocationState(
      loading: false,
      loaded: false,
      error: null,
      locations: List<Location>(),
    );
  }

  LocationState copyWith({
    bool loading,
    bool loaded,
    String error,
    List<Location> locations,
  }) {
    return LocationState(
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
      error: error ?? this.error,
      locations: locations ?? this.locations,
    );
  }
}
