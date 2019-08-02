import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/models/user_notification.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/providers/user_notification.dart';
import 'package:provider/provider.dart';

class UserNotificationsPage extends StatefulWidget {
  @override
  _UserNotificationsPage createState() => _UserNotificationsPage();
}

class _UserNotificationsPage extends State<UserNotificationsPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final UserNotificationBloc userNotificationBloc =
        Provider.of<UserNotificationBloc>(context);

    await userNotificationBloc.getUserNotifications(userBloc);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserNotificationBloc userNotificationBloc =
        Provider.of<UserNotificationBloc>(context);
    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.groupScoreboard.backgroundColor,
      body: SafeArea(
        child: userNotificationBloc.loading == true
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      primary: true,
                      shrinkWrap: true,
                      itemCount: userNotificationBloc.notifications.length,
                      itemBuilder: (context, index) {
                        return getNotificationLayout(
                          userNotificationBloc,
                          index,
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget getNotificationLayout(
    UserNotificationBloc userNotificationBloc,
    int index,
  ) {
    UserNotification notification = userNotificationBloc.notifications[index];

    Widget notificationDisplay;

    if (notification.type == "App\\Notifications\\PostCreated") {
      notificationDisplay = Text("PostCreated");
    }

    if (notification.type == "App\\Notifications\\PostLiked") {
      notificationDisplay = Text("PostLiked");
    }

    if (notification.type == "App\\Notifications\\UserFollowed") {
      notificationDisplay = Text("UserFollowed");
    }

    return notificationDisplay;
  }
}
