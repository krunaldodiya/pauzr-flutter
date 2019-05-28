import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/atp/screens/intro.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/screens/request_otp.dart';
import 'package:pauzr/src/atp/screens/tabs.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/screens/verify_otp.dart';
import 'package:pauzr/src/atp/themes/red/intro1.dart';
import 'package:pauzr/src/atp/themes/red/intro.dart';
import 'package:pauzr/src/atp/themes/red/intro2.dart';
import 'package:pauzr/src/atp/themes/red/intro3.dart';
import 'package:pauzr/src/atp/themes/red/request_otp.dart';
import 'package:pauzr/src/atp/themes/red/tabs.dart';
import 'package:pauzr/src/atp/themes/red/timer.dart';
import 'package:pauzr/src/atp/themes/red/verify_otp.dart';

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
  Timer timer = timerTheme;
  @override
  RequestOtp requestOtp = requestOtpTheme;
  @override
  VerifyOtp verifyOtp = verifyOtpTheme;
  @override
  Tabs tabs = tabsTheme;
}
