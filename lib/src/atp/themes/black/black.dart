import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/atp/screens/intro1.dart';
import 'package:pauzr/src/atp/screens/intro2.dart';
import 'package:pauzr/src/atp/screens/intro3.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/themes/black/intro1.dart';
import 'package:pauzr/src/atp/themes/black/intro2.dart';
import 'package:pauzr/src/atp/themes/black/intro3.dart';
import 'package:pauzr/src/atp/themes/black/timer.dart';

class Black implements DefaultTheme {
  @override
  Intro1 intro1 = intro1Black;
  Intro2 intro2 = intro2Black;
  Intro3 intro3 = intro3Black;
  Timer timer = timerBlack;
}
