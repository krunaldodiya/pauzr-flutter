import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/initial_screen/bloc.dart';
import 'package:pauzr/src/blocs/location/bloc.dart';
import 'package:pauzr/src/blocs/otp/bloc.dart';
import 'package:pauzr/src/blocs/profession/bloc.dart';
import 'package:pauzr/src/blocs/user/bloc.dart';

class ProviderList {
  static List<BlocProvider<Bloc>> getBlocProviders() {
    return [
      BlocProvider<InitialScreenBloc>(bloc: InitialScreenBloc()),
      BlocProvider<UserBloc>(bloc: UserBloc()),
      BlocProvider<OtpBloc>(bloc: OtpBloc()),
      BlocProvider<LocationBloc>(bloc: LocationBloc()),
      BlocProvider<ProfessionBloc>(bloc: ProfessionBloc()),
    ];
  }
}
