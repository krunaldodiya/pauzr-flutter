import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/atp/screens/intro.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/screens/request_otp.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/screens/verify_otp.dart';
import 'package:pauzr/src/atp/themes/black/intro.dart';
import 'package:pauzr/src/atp/themes/black/intro1.dart';
import 'package:pauzr/src/atp/themes/black/intro2.dart';
import 'package:pauzr/src/atp/themes/black/intro3.dart';
import 'package:pauzr/src/atp/themes/black/request_otp.dart';
import 'package:pauzr/src/atp/themes/black/timer.dart';
import 'package:pauzr/src/atp/themes/black/verify_otp.dart';

class Black implements DefaultTheme {
  @override
  Intro intro = introBlack;
  @override
  Intro1 intro1 = intro1Black;
  @override
  Intro2 intro2 = intro2Black;
  @override
  Intro3 intro3 = intro3Black;
  @override
  Timer timer = timerBlack;
  @override
  RequestOtp requestOtp = requestOtpBlack;
  @override
  VerifyOtp verifyOtp = verifyOtpBlack;
}
