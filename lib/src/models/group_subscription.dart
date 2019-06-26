import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class GroupSubscription {
  final int id;
  final int groupId;
  final int subscriberId;
  final bool isAdmin;
  final User subscriber;

  GroupSubscription({
    this.id,
    this.groupId,
    this.subscriberId,
    this.isAdmin,
    this.subscriber,
  });

  GroupSubscription copyWith(Map<String, dynamic> json) {
    return GroupSubscription(
      id: json["id"] ?? this.id,
      groupId: json["groupId"] ?? this.groupId,
      subscriberId: json["subscriberId"] ?? this.subscriberId,
      isAdmin: json["isAdmin"] ?? this.isAdmin,
      subscriber: json["subscriber"] ?? this.subscriber,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return GroupSubscription(
      id: json["id"] != null ? json["id"] : null,
      groupId: json["groupId"] != null ? json["groupId"] : null,
      subscriberId: json["subscriberId"] != null ? json["subscriberId"] : null,
      isAdmin: json["isAdmin"] != null ? json["isAdmin"] : null,
      subscriber: json["subscriber"] != null
          ? json["subscriber"] is User
              ? json["subscriber"]
              : User.fromMap(json["subscriber"])
          : null,
    );
  }

  static fromList(List subscriptions) {
    List<GroupSubscription> list = List<GroupSubscription>();

    for (Map subscription in subscriptions) {
      list.add(GroupSubscription.fromMap(subscription));
    }

    return list;
  }
}
