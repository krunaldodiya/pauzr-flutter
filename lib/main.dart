import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/provider_list.dart';
import 'package:pauzr/src/providers/group.dart';
import 'package:pauzr/src/providers/location.dart';
import 'package:pauzr/src/providers/otp.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String authToken = prefs.getString("authToken");
  String defaultTheme = prefs.getString("defaultTheme") ?? "black";

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GroupBloc>.value(
          notifier: GroupBloc(),
        ),
        ChangeNotifierProvider<LocationBloc>.value(
          notifier: LocationBloc(),
        ),
        ChangeNotifierProvider<UserBloc>.value(
          notifier: UserBloc(),
        ),
        ChangeNotifierProvider<ThemeBloc>.value(
          notifier: ThemeBloc(),
        ),
        ChangeNotifierProvider<OtpBloc>.value(
          notifier: OtpBloc(),
        ),
      ],
      child: BlocProviderTree(
        blocProviders: ProviderList.getBlocProviders(),
        child: MyApp(authToken: authToken, defaultTheme: defaultTheme),
      ),
    ),
  );
}
