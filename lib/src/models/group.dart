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
  final User owner;
  final List<GroupSubscription> subscriptions;
  final String createdAt;
  final String updatedAt;

  Group({
    this.id,
    this.name,
    this.description,
    this.photo,
    this.status,
    this.owner,
    this.subscriptions,
    this.createdAt,
    this.updatedAt,
  });

  Group copyWith(Map<String, dynamic> json) {
    return Group(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      description: json["description"] ?? this.description,
      photo: json["photo"] ?? this.photo,
      status: json["status"] ?? this.status,
      owner: json["owner"] ?? this.owner,
      subscriptions: json["subscriptions"] ?? this.subscriptions,
      createdAt: json["created_at"] ?? this.createdAt,
      updatedAt: json["updated_at"] ?? this.updatedAt,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Group(
      id: json["id"] != null ? json["id"] : null,
      name: json["name"] != null ? json["name"] : null,
      description: json["description"] != null ? json["description"] : null,
      photo: json["photo"] != null ? json["photo"] : null,
      status: json["status"] != null ? json["status"] : null,
      owner: json["owner"] != null
          ? json["owner"] is User ? json["owner"] : User.fromMap(json["owner"])
          : null,
      subscriptions: json["subscriptions"] != null
          ? json["subscriptions"] is List<GroupSubscription>
              ? json["subscriptions"]
              : GroupSubscription.fromList(json["subscriptions"])
          : null,
      createdAt: json["created_at"] != null ? json["created_at"] : null,
      updatedAt: json["updated_at"] != null ? json["updated_at"] : null,
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
