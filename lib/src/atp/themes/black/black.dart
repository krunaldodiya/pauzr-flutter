import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/atp/screens/drawer_menu.dart';
import 'package:pauzr/src/atp/screens/intro.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/screens/request_otp.dart';
import 'package:pauzr/src/atp/screens/tabs.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/screens/verify_otp.dart';
import 'package:pauzr/src/atp/themes/black/drawer.dart';
import 'package:pauzr/src/atp/themes/black/intro.dart';
import 'package:pauzr/src/atp/themes/black/intro1.dart';
import 'package:pauzr/src/atp/themes/black/intro2.dart';
import 'package:pauzr/src/atp/themes/black/intro3.dart';
import 'package:pauzr/src/atp/themes/black/request_otp.dart';
import 'package:pauzr/src/atp/themes/black/tabs.dart';
import 'package:pauzr/src/atp/themes/black/timer.dart';
import 'package:pauzr/src/atp/themes/black/verify_otp.dart';

class Black implements DefaultTheme {
  @override
  Intro intro = introTheme;
  @override
  Intro1 intro1 = intro1Theme;
  @override
  Intro2 intro2 = intro2Theme;
  @override
  Intro3 intro3 = intro3Theme;
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
}
