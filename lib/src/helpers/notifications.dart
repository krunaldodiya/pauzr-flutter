import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  Map payload;
  Function onSelectNotification;

  NotificationManager.close(id) {
    notifications.cancel(id);
  }

  NotificationManager({
    Map payload,
    Function onSelectNotification,
  }) {
    this.payload = payload;
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
      payload['id'],
      payload['title'],
      payload['body'],
      NotificationDetails(android, ios),
      payload: json.encode(payload),
    );
  }
}
