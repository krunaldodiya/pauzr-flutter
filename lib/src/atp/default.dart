import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/screens/bottom_navigation.dart';
import 'package:pauzr/src/atp/screens/edit_profile.dart';
import 'package:pauzr/src/atp/screens/home.dart';
import 'package:pauzr/src/atp/screens/intro.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/screens/request_otp.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/screens/tabs.dart';
import 'package:pauzr/src/atp/screens/drawer_menu.dart';
import 'package:pauzr/src/atp/screens/verify_otp.dart';
import 'package:pauzr/src/atp/screens/view_profile.dart';
import 'package:pauzr/src/atp/themes/black/black.dart';
import 'package:pauzr/src/atp/themes/blue/blue.dart';
import 'package:pauzr/src/atp/themes/red/red.dart';

class DefaultTheme {
  static Map themes = {
    "red": Red(),
    "black": Black(),
    "blue": Blue(),
  };

  Intro intro;
  Intro1 intro1;
  Intro2 intro2;
  Intro3 intro3;
  Home home;
  Timer timer;
  Tabs tabs;
  DrawerMenu drawerMenu;
  BottomNavigation bottomNavigation;
  RequestOtp requestOtp;
  VerifyOtp verifyOtp;
  EditProfile editProfile;
  ViewProfile viewProfile;

  DefaultTheme({
    @required this.intro,
    @required this.intro1,
    @required this.intro2,
    @required this.intro3,
    @required this.home,
    @required this.timer,
    @required this.tabs,
    @required this.drawerMenu,
    @required this.bottomNavigation,
    @required this.requestOtp,
    @required this.verifyOtp,
    @required this.editProfile,
    @required this.viewProfile,
  });

  static DefaultTheme defaultTheme(String themeName) {
    var theme = themes[themeName];

    return DefaultTheme(
      intro: theme.intro,
      intro1: theme.intro1,
      intro2: theme.intro2,
      intro3: theme.intro3,
      home: theme.home,
      timer: theme.timer,
      tabs: theme.tabs,
      drawerMenu: theme.drawerMenu,
      bottomNavigation: theme.bottomNavigation,
      requestOtp: theme.requestOtp,
      verifyOtp: theme.verifyOtp,
      editProfile: theme.editProfile,
      viewProfile: theme.viewProfile,
    );
  }
}
