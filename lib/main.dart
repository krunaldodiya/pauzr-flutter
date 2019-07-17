import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/providers/city.dart';
import 'package:pauzr/src/providers/country.dart';
import 'package:pauzr/src/providers/group.dart';
import 'package:pauzr/src/providers/otp.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/timer.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/providers/wallet.dart';
import 'package:pauzr/src/screens/app.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/providers/ranking.dart';

void main() async {
  Screen.keepOn(false);

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String authToken = prefs.getString("authToken");
  String defaultTheme = prefs.getString("defaultTheme") ?? "blue";

  managePushNotifications();

  // prefs.remove("authToken");
  // prefs.remove("contacts");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WalletBloc>.value(
          notifier: WalletBloc(),
        ),
        ChangeNotifierProvider<RankingBloc>.value(
          notifier: RankingBloc(),
        ),
        ChangeNotifierProvider<TimerBloc>.value(
          notifier: TimerBloc(),
        ),
        ChangeNotifierProvider<GroupBloc>.value(
          notifier: GroupBloc(),
        ),
        ChangeNotifierProvider<CityBloc>.value(
          notifier: CityBloc(),
        ),
        ChangeNotifierProvider<CountryBloc>.value(
          notifier: CountryBloc(),
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
      child: MyApp(
        authToken: authToken,
        defaultTheme: defaultTheme,
      ),
    ),
  );
}

void managePushNotifications() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      prefs.setString("newPushMessage", json.encode(message));
    },
    onResume: (Map<String, dynamic> message) async {
      prefs.setString("newPushMessage", json.encode(message));
    },
    onLaunch: (Map<String, dynamic> message) async {
      prefs.setString("newPushMessage", json.encode(message));
    },
  );

  firebaseMessaging.requestNotificationPermissions(
    IosNotificationSettings(sound: true, badge: true, alert: true),
  );
}
