import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/user_notification.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/resources/api.dart';

class UserNotificationBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error = const {};
  List<UserNotification> notifications = [];

  setState({
    bool loading,
    bool loaded,
    Map error,
    List<UserNotification> notifications,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.notifications = notifications ?? this.notifications;

    notifyListeners();
  }

  getUserNotifications(UserBloc userBloc) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getUserNotifications();
      final results = response.data;

      final List<UserNotification> notifications =
          UserNotification.fromList(results['notifications']);

      setState(notifications: notifications, loading: false, loaded: true);
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }

  markAsRead(UserNotification notification) async {
    try {
      final Response response = await _apiProvider.markAsRead(notification.id);
      final results = response.data;

      final List<UserNotification> notifications =
          UserNotification.fromList(results['notifications']);

      setState(notifications: notifications);
    } catch (error) {
      print(error);
    }
  }
}
