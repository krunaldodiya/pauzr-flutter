import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/atp/screens/bottom_navigation.dart';
import 'package:pauzr/src/atp/screens/drawer_menu.dart';
import 'package:pauzr/src/atp/screens/edit_profile.dart';
import 'package:pauzr/src/atp/screens/group_detail.dart';
import 'package:pauzr/src/atp/screens/group_scoreboard.dart';
import 'package:pauzr/src/atp/screens/home.dart';
import 'package:pauzr/src/atp/screens/intro.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/screens/levels.dart';
import 'package:pauzr/src/atp/screens/main_scoreboard.dart';
import 'package:pauzr/src/atp/screens/manage_group.dart';
import 'package:pauzr/src/atp/screens/minutes.dart';
import 'package:pauzr/src/atp/screens/points.dart';
import 'package:pauzr/src/atp/screens/request_otp.dart';
import 'package:pauzr/src/atp/screens/stop.dart';
import 'package:pauzr/src/atp/screens/tabs.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/screens/verify_otp.dart';
import 'package:pauzr/src/atp/screens/view_profile.dart';
import 'package:pauzr/src/atp/themes/blue/bottom_navigation.dart';
import 'package:pauzr/src/atp/themes/blue/drawer.dart';
import 'package:pauzr/src/atp/themes/blue/edit_profile.dart';
import 'package:pauzr/src/atp/themes/blue/group_detail.dart';
import 'package:pauzr/src/atp/themes/blue/group_scoreboard.dart';
import 'package:pauzr/src/atp/themes/blue/home.dart';
import 'package:pauzr/src/atp/themes/blue/intro.dart';
import 'package:pauzr/src/atp/themes/blue/intro1.dart';
import 'package:pauzr/src/atp/themes/blue/intro2.dart';
import 'package:pauzr/src/atp/themes/blue/intro3.dart';
import 'package:pauzr/src/atp/themes/blue/levels.dart';
import 'package:pauzr/src/atp/themes/blue/main_scoreboard.dart';
import 'package:pauzr/src/atp/themes/blue/manage_group.dart';
import 'package:pauzr/src/atp/themes/blue/minutes.dart';
import 'package:pauzr/src/atp/themes/blue/points.dart';
import 'package:pauzr/src/atp/themes/blue/request_otp.dart';
import 'package:pauzr/src/atp/themes/blue/stop.dart';
import 'package:pauzr/src/atp/themes/blue/tabs.dart';
import 'package:pauzr/src/atp/themes/blue/timer.dart';
import 'package:pauzr/src/atp/themes/blue/verify_otp.dart';
import 'package:pauzr/src/atp/themes/blue/view_profile.dart';

class Blue implements DefaultTheme {
  @override
  Intro intro = introTheme;
  @override
  Intro1 intro1 = intro1Theme;
  @override
  Intro2 intro2 = intro2Theme;
  @override
  Intro3 intro3 = intro3Theme;
  @override
  Home home = homeTheme;
  @override
  Timer timer = timerTheme;
  @override
  RequestOtp requestOtp = requestOtpTheme;
  @override
  VerifyOtp verifyOtp = verifyOtpTheme;
  @override
  Tabs tabs = tabsTheme;
  @override
  DrawerMenu drawerMenu = drawerMenuTheme;
  @override
  EditProfile editProfile = editProfileTheme;
  @override
  ViewProfile viewProfile = viewProfileTheme;
  @override
  BottomNavigation bottomNavigation = bottomNavigationTheme;
  @override
  MainScoreboard mainScoreboard = mainScoreboardTheme;
  @override
  GroupScoreboard groupScoreboard = groupScoreboardTheme;
  @override
  GroupDetail groupDetail = groupDetailTheme;
  @override
  Levels levels = levelsTheme;
  @override
  ManageGroup manageGroup = manageGroupTheme;
  @override
  Minutes minutes = minutesTheme;
  @override
  Points points = pointsTheme;
  @override
  Stop stop = stopTheme;
}
