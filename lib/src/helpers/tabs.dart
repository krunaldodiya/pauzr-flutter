import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/atp/screens/home.dart';
import 'package:pauzr/src/atp/screens/main_scoreboard.dart';
import 'package:pauzr/src/atp/screens/timer.dart';
import 'package:pauzr/src/atp/screens/user_notification.dart';
import 'package:pauzr/src/screens/tabs/group.dart';
import 'package:pauzr/src/screens/tabs/main_scoreboard.dart';
import 'package:pauzr/src/screens/tabs/user_notifications.dart';
import 'package:pauzr/src/screens/tabs/timer.dart';
import 'package:pauzr/src/screens/tabs/lottery.dart';

getTabsPage(int showTabIndex) {
  switch (showTabIndex) {
    case 0:
      return LotteryPage();
      break;

    case 1:
      return HomePage();
      break;

    case 2:
      return TimerPage();
      break;

    case 3:
      return MainScoreboardPage();
      break;

    case 4:
      return UserNotificationsPage();
      break;

    default:
      return TimerPage();
  }
}

getTabsTheme(int showTabIndex, DefaultTheme theme) {
  Home home = theme.home;
  Timer timer = theme.timer;
  MainScoreboard mainScoreboard = theme.mainScoreboard;
  UserNotification userNotification = theme.userNotification;

  switch (showTabIndex) {
    case 0:
      return mainScoreboard;
      break;

    case 1:
      return home;
      break;

    case 2:
      return timer;
      break;

    case 3:
      return mainScoreboard;
      break;

    case 4:
      return userNotification;
      break;

    default:
      return timer;
  }
}
