import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  int id;
  String title;
  String body;
  Function onSelectNotification;

  NotificationManager.close(id) {
    notifications.cancel(id);
  }

  NotificationManager({
    int id,
    String title,
    String body,
    Function onSelectNotification,
  }) {
    this.id = id;
    this.title = title;
    this.body = body;
    this.onSelectNotification = onSelectNotification;

    final settingAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settingIos = IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
        return onSelectNotification(payload);
      },
    );

    notifications.initialize(
      InitializationSettings(settingAndroid, settingIos),
      onSelectNotification: onSelectNotification,
    );
  }

  Future showOngoingNotification() async {
    final android = AndroidNotificationDetails(
      "channel_id",
      "channel_name",
      "channel_description",
      importance: Importance.Max,
      priority: Priority.High,
      ongoing: true,
      autoCancel: false,
    );

    final ios = IOSNotificationDetails();

    return notifications.show(
      id,
      title,
      body,
      NotificationDetails(android, ios),
      payload: json.encode({"id": id, "title": title, "body": body}),
    );
  }
}
