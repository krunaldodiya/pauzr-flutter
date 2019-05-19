import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/screens/intro.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/screens/request_otp.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/screens/verify_otp.dart';
import 'package:pauzr/src/atp/themes/black/black.dart';
import 'package:pauzr/src/atp/themes/red/red.dart';

class DefaultTheme {
  static Map themes = {
    "red": Red(),
    "black": Black(),
  };

  Intro intro;
  Intro1 intro1;
  Intro2 intro2;
  Intro3 intro3;
  Timer timer;
  RequestOtp requestOtp;
  VerifyOtp verifyOtp;

  DefaultTheme({
    @required this.intro,
    @required this.intro1,
    @required this.intro2,
    @required this.intro3,
    @required this.timer,
    @required this.requestOtp,
    @required this.verifyOtp,
  });

  static DefaultTheme defaultTheme(theme) {
    return DefaultTheme(
      intro: theme.intro,
      intro1: theme.intro1,
      intro2: theme.intro2,
      intro3: theme.intro3,
      timer: theme.timer,
      requestOtp: theme.requestOtp,
      verifyOtp: theme.verifyOtp,
    );
  }
}
