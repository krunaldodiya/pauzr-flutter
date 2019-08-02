import 'package:flutter/material.dart';
import 'package:pauzr/src/atp/default.dart';
import 'package:pauzr/src/helpers/fonts.dart';
import 'package:pauzr/src/models/user_notification.dart';
import 'package:pauzr/src/providers/theme.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/providers/user_notification.dart';
import 'package:pauzr/src/screens/notifications/post_created.dart';
import 'package:pauzr/src/screens/notifications/post_liked.dart';
import 'package:pauzr/src/screens/notifications/user_followed.dart';
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
    final DefaultTheme theme = themeBloc.theme;

    final UserNotificationBloc userNotificationBloc =
        Provider.of<UserNotificationBloc>(context);

    return Scaffold(
      backgroundColor: theme.userNotification.backgroundColor,
      body: SafeArea(
        child: userNotificationBloc.loading == true
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  userNotificationBloc.notifications.length == 0
                      ? Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(
                            "No new notifications.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            primary: true,
                            shrinkWrap: true,
                            itemCount:
                                userNotificationBloc.notifications.length,
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
      notificationDisplay = PostCreated(notification: notification);
    }

    if (notification.type == "App\\Notifications\\PostLiked") {
      notificationDisplay = PostLiked(notification: notification);
    }

    if (notification.type == "App\\Notifications\\UserFollowed") {
      notificationDisplay = UserFollowed(notification: notification);
    }

    return notificationDisplay;
  }
}
