import 'package:pauzr/src/models/user_notification.dart';
import 'package:pauzr/src/providers/user_notification.dart';

markAsRead(UserNotification notification) {
  final UserNotificationBloc notificationBloc = UserNotificationBloc();
  notificationBloc.markAsRead(notification);
}
