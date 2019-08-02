import 'package:meta/meta.dart';

@immutable
class UserNotification {
  final String id;
  final String type;
  final String notifiableType;
  final String notifiableId;
  final Map data;
  final String readAt;

  UserNotification({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
  });

  UserNotification copyWith(Map<String, dynamic> json) {
    return UserNotification(
      id: json["id"] ?? this.id,
      type: json["type"] ?? this.type,
      notifiableType: json["notifiableType"] ?? this.notifiableType,
      notifiableId: json["notifiableId"] ?? this.notifiableId,
      data: json["data"] ?? this.data,
      readAt: json["readAt"] ?? this.readAt,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return UserNotification(
      id: json["id"] != null ? json["id"] : null,
      type: json['type'] != null ? json["type"] : null,
      notifiableType:
          json['notifiableType'] != null ? json["notifiableType"] : null,
      notifiableId: json['notifiableId'] != null ? json["notifiableId"] : null,
      data: json['data'] != null ? json["data"] : null,
      readAt: json['readAt'] != null ? json["readAt"] : null,
    );
  }

  static fromList(List notifications) {
    List<UserNotification> list = List<UserNotification>();

    for (Map notification in notifications) {
      list.add(UserNotification.fromMap(notification));
    }

    return list;
  }
}
