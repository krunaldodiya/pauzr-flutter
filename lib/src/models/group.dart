import 'package:meta/meta.dart';
import 'package:pauzr/src/models/group_subscription.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Group {
  final int id;
  final String name;
  final String photo;
  final String description;
  final int status;
  final String createdAt;
  final User owner;
  final List<GroupSubscription> subscriptions;

  Group({
    this.id,
    this.name,
    this.description,
    this.photo,
    this.status,
    this.createdAt,
    this.owner,
    this.subscriptions,
  });

  Group copyWith(Map<String, dynamic> json) {
    return Group(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      description: json["description"] ?? this.description,
      photo: json["photo"] ?? this.photo,
      status: json["status"] ?? this.status,
      createdAt: json["created_at"] ?? this.createdAt,
      owner: json["owner"] ?? this.owner,
      subscriptions: json["subscriptions"] ?? this.subscriptions,
    );
  }

  Group.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        name = json != null ? json["name"] : null,
        description = json != null ? json["description"] : null,
        photo = json != null ? json["photo"] : null,
        status = json != null ? json["status"] : null,
        createdAt = json != null ? json["created_at"] : null,
        owner =
            json["owner"] is User ? json["owner"] : User.fromMap(json["owner"]),
        subscriptions = json["subscriptions"] is List<GroupSubscription>
            ? json["subscriptions"]
            : GroupSubscription.fromList(json["subscriptions"]);

  static fromList(List groups) {
    List<Group> list = List<Group>();

    for (Map group in groups) {
      list.add(Group.fromMap(group['group']));
    }

    return list;
  }
}
