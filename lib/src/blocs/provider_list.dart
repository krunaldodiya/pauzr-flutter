import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/timer/bloc.dart';

class ProviderList {
  static List<BlocProvider<Bloc>> getBlocProviders() {
    return [
      BlocProvider<TimerBloc>(bloc: TimerBloc()),
    ];
  }
}
