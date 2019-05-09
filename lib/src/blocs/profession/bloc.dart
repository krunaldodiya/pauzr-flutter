import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:pauzr/src/blocs/profession/event.dart';
import 'package:pauzr/src/blocs/profession/state.dart';
import 'package:pauzr/src/models/profession.dart';
import 'package:pauzr/src/resources/api.dart';

class ProfessionBloc extends Bloc<ProfessionEvent, ProfessionState> {
  final ApiProvider _apiProvider = ApiProvider();

  void getProfession() {
    dispatch(GetProfession());
  }

  @override
  ProfessionState get initialState => ProfessionState.initial();

  @override
  Stream<ProfessionState> mapEventToState(ProfessionEvent event) async* {
    if (event is GetProfession) {
      yield currentState.copyWith(loading: true);

      try {
        final response = await _apiProvider.getProfessions();
        final results = json.decode(response.body);
        final List professions = results['professions'];

        if (professions.isNotEmpty) {
          yield currentState.copyWith(
            professions: Profession.fromList(professions),
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
