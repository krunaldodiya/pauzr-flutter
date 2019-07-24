import 'dart:convert';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/app_bar.dart';
import 'package:pauzr/bottom_navigation.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/admob.dart';
import 'package:pauzr/src/helpers/tabs.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/screens/drawer.dart';
import 'package:pauzr/src/screens/helpers/confirm.dart';
import 'package:pauzr/src/screens/notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPage createState() => _TabsPage();
}

class _TabsPage extends State<TabsPage> with SingleTickerProviderStateMixin {
  InterstitialAd _interstitialAd;

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance.initialize(appId: admobAppId);

    _interstitialAd = createInterstitialAd()
      ..load()
      ..show();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String newPushMessage = prefs.getString("newPushMessage");

    if (newPushMessage != null) {
      final Map message = json.decode(newPushMessage);

      showConfirmationPopup(
        context,
        yesText: "Show",
        noText: "Dismiss",
        message: "New Notification",
        onPressYes: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationsScreen(message: message),
            ),
          );
        },
      );

      prefs.remove("newPushMessage");
    }
  }

  @override
  void dispose() {
    _interstitialAd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.tabs.backgroundColor,
      appBar: getAppBar(context, userBloc, theme),
      body: SafeArea(child: getTabsPage(userBloc.tabIndex)),
      bottomNavigationBar: getNavigationBar(userBloc, theme),
      drawer: Drawer(
        child: DrawerPage(userBloc: userBloc, themeBloc: themeBloc),
      ),
    );
  }
}
