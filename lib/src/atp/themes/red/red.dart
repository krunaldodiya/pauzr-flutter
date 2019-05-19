import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/themes/red/intro1.dart';
import 'package:pauzr/src/atp/themes/red/intro2.dart';
import 'package:pauzr/src/atp/themes/red/intro3.dart';
import 'package:pauzr/src/atp/themes/red/timer.dart';

class Red implements DefaultTheme {
  @override
  Intro1 intro1 = intro1Red;
  Intro2 intro2 = intro2Red;
  Intro3 intro3 = intro3Red;
  Timer timer = timerRed;
}
