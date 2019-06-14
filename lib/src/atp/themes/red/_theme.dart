import 'package:pauzr/src/atp/default.dart';
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
import 'package:pauzr/src/atp/screens/verify_otp.dart';
import 'package:pauzr/src/atp/screens/view_profile.dart';
import 'package:pauzr/src/atp/themes/red/add_group_participants.dart';
import 'package:pauzr/src/atp/themes/red/drawer.dart';
import 'package:pauzr/src/atp/themes/red/edit_profile.dart';
import 'package:pauzr/src/atp/themes/red/group_detail.dart';
import 'package:pauzr/src/atp/themes/red/group_scoreboard.dart';
import 'package:pauzr/src/atp/themes/red/home.dart';
import 'package:pauzr/src/atp/themes/red/intro.dart';
import 'package:pauzr/src/atp/themes/red/intro1.dart';
import 'package:pauzr/src/atp/themes/red/intro2.dart';
import 'package:pauzr/src/atp/themes/red/intro3.dart';
import 'package:pauzr/src/atp/themes/red/levels.dart';
import 'package:pauzr/src/atp/themes/red/main_scoreboard.dart';
import 'package:pauzr/src/atp/themes/red/manage_group.dart';
import 'package:pauzr/src/atp/themes/red/minutes.dart';
import 'package:pauzr/src/atp/themes/red/points.dart';
import 'package:pauzr/src/atp/themes/red/request_otp.dart';
import 'package:pauzr/src/atp/themes/red/segment_bar.dart';
import 'package:pauzr/src/atp/themes/red/stop.dart';
import 'package:pauzr/src/atp/themes/red/tabs.dart';
import 'package:pauzr/src/atp/themes/red/timer.dart';
import 'package:pauzr/src/atp/themes/red/verify_otp.dart';
import 'package:pauzr/src/atp/themes/red/view_profile.dart';

class Red implements DefaultTheme {
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
  MainScoreboard mainScoreboard = mainScoreboardTheme;
  @override
  GroupScoreboard groupScoreboard = groupScoreboardTheme;
  @override
  AddGroupParticipants addGroupParticipants = addGroupParticipantsTheme;
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
  @override
  SegmentBar segmentBar = segmentBarTheme;
}
