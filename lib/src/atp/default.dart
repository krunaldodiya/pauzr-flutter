import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/screens/add_group_participants.dart';
import 'package:pauzr/src/atp/screens/drawer_menu.dart';
import 'package:pauzr/src/atp/screens/edit_profile.dart';
import 'package:pauzr/src/atp/screens/group_detail.dart';
import 'package:pauzr/src/atp/screens/group_scoreboard.dart';
import 'package:pauzr/src/atp/screens/home.dart';
import 'package:pauzr/src/atp/screens/intro.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/screens/intro4.dart';
import 'package:pauzr/src/atp/screens/levels.dart';
import 'package:pauzr/src/atp/screens/main_scoreboard.dart';
import 'package:pauzr/src/atp/screens/manage_group.dart';
import 'package:pauzr/src/atp/screens/minutes.dart';
import 'package:pauzr/src/atp/screens/points.dart';
import 'package:pauzr/src/atp/screens/request_otp.dart';
import 'package:pauzr/src/atp/screens/segment_bar.dart';
import 'package:pauzr/src/atp/screens/stop.dart';
import 'package:pauzr/src/atp/screens/tabs.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/screens/user_notification.dart';
import 'package:pauzr/src/atp/screens/verify_otp.dart';
import 'package:pauzr/src/atp/screens/view_profile.dart';
import 'package:pauzr/src/atp/themes/black/_theme.dart';
import 'package:pauzr/src/atp/themes/blue/_theme.dart';
import 'package:pauzr/src/atp/themes/red/_theme.dart';

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
  Intro4 intro4;
  Home home;
  Timer timer;
  Tabs tabs;
  DrawerMenu drawerMenu;
  RequestOtp requestOtp;
  VerifyOtp verifyOtp;
  EditProfile editProfile;
  ViewProfile viewProfile;
  MainScoreboard mainScoreboard;
  GroupScoreboard groupScoreboard;
  AddGroupParticipants addGroupParticipants;
  GroupDetail groupDetail;
  Levels levels;
  ManageGroup manageGroup;
  Minutes minutes;
  Points points;
  Stop stop;
  SegmentBar segmentBar;
  UserNotification userNotification;

  DefaultTheme({
    @required this.intro,
    @required this.intro1,
    @required this.intro2,
    @required this.intro3,
    @required this.intro4,
    @required this.home,
    @required this.timer,
    @required this.tabs,
    @required this.drawerMenu,
    @required this.requestOtp,
    @required this.verifyOtp,
    @required this.editProfile,
    @required this.viewProfile,
    @required this.mainScoreboard,
    @required this.groupScoreboard,
    @required this.addGroupParticipants,
    @required this.groupDetail,
    @required this.levels,
    @required this.manageGroup,
    @required this.minutes,
    @required this.points,
    @required this.stop,
    @required this.segmentBar,
    @required this.userNotification,
  });

  static DefaultTheme defaultTheme(String themeName) {
    var theme = themes[themeName];

    return DefaultTheme(
      intro: theme.intro,
      intro1: theme.intro1,
      intro2: theme.intro2,
      intro3: theme.intro3,
      intro4: theme.intro4,
      home: theme.home,
      timer: theme.timer,
      tabs: theme.tabs,
      drawerMenu: theme.drawerMenu,
      requestOtp: theme.requestOtp,
      verifyOtp: theme.verifyOtp,
      editProfile: theme.editProfile,
      viewProfile: theme.viewProfile,
      mainScoreboard: theme.mainScoreboard,
      groupScoreboard: theme.groupScoreboard,
      addGroupParticipants: theme.addGroupParticipants,
      groupDetail: theme.groupDetail,
      levels: theme.levels,
      manageGroup: theme.manageGroup,
      minutes: theme.minutes,
      points: theme.points,
      stop: theme.stop,
      segmentBar: theme.segmentBar,
      userNotification: theme.userNotification,
    );
  }
}
