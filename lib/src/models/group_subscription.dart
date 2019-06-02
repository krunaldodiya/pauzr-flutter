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

  GroupSubscription.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        groupId = json != null ? json["groupId"] : null,
        subscriberId = json != null ? json["subscriberId"] : null,
        isAdmin = json != null ? json["isAdmin"] : null,
        subscriber = json["subscriber"] is User
            ? json["subscriber"]
            : User.fromMap(json["subscriber"]);

  static fromList(List subscriptions) {
    List<GroupSubscription> list = List<GroupSubscription>();

    for (Map subscription in subscriptions) {
      list.add(GroupSubscription.fromMap(subscription));
    }

    return list;
  }
}
