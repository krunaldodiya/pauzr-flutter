import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/atp/screens/home.dart';
import 'package:pauzr/src/atp/screens/main_scoreboard.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/screens/tabs/home.dart';
import 'package:pauzr/src/screens/tabs/main_scoreboard.dart';
import 'package:pauzr/src/screens/tabs/timer.dart';

getTabsPage(int showTabIndex) {
  switch (showTabIndex) {
    case 0:
      return HomePage();
      break;

    case 1:
      return TimerPage();
      break;

    case 2:
      return MainScoreboardPage();
      break;

    default:
      return TimerPage();
  }
}

getTabsTheme(int showTabIndex, DefaultTheme theme) {
  Home home = theme.home;
  Timer timer = theme.timer;
  MainScoreboard mainScoreboard = theme.mainScoreboard;

  switch (showTabIndex) {
    case 0:
      return home;
      break;

    case 1:
      return timer;
      break;

    case 2:
      return mainScoreboard;
      break;

    default:
      return timer;
  }
}
