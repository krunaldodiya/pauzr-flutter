import 'package:meta/meta.dart';
import 'package:pauzr/src/models/user.dart';

@immutable
class Follower {
  final List users;

  Follower({this.users});

  Follower copyWith(Map<String, dynamic> json) {
    return Follower(
      users: json["follower_user"] ?? this.users,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Follower(
      users: json['follower_user'] != null
          ? json["follower_user"] is User
              ? json["follower_user"]
              : User.fromMap(json["follower_user"])
          : null,
    );
  }

  static fromList(List followers) {
    List list = List();

    for (Map follower in followers) {
      list.add(follower['follower_user']);
    }

    return list;
  }
}
