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

  static fromMap(Map<String, dynamic> json) {
    return Group(
      id: json["id"] != null ? json["id"] : null,
      name: json["name"] != null ? json["name"] : null,
      description: json["description"] != null ? json["description"] : null,
      photo: json["photo"] != null ? json["photo"] : null,
      status: json["status"] != null ? json["status"] : null,
      createdAt: json["created_at"] != null ? json["created_at"] : null,
      owner: json["owner"] != null
          ? json["owner"] is User ? json["owner"] : User.fromMap(json["owner"])
          : null,
      subscriptions: json["subscriptions"] != null
          ? json["subscriptions"] is List<GroupSubscription>
              ? json["subscriptions"]
              : GroupSubscription.fromList(json["subscriptions"])
          : null,
    );
  }

  static fromList(List groups) {
    List<Group> list = List<Group>();

    for (Map group in groups) {
      list.add(Group.fromMap(group['group']));
    }

    return list;
  }
}
