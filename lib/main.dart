import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pauzr/src/blocs/provider_list.dart';
import 'package:pauzr/src/screens/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString("authToken");
  // prefs.remove("authToken");

  runApp(
    BlocProviderTree(
      blocProviders: ProviderList.getBlocProviders(),
      child: MyApp(authToken: authToken),
    ),
  );
}
